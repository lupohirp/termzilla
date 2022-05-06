import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:tabbed_view/tabbed_view.dart';
import 'package:termzilla/shared/model/termzilla.connectioninfo.model.dart';
import 'package:xterm/next.dart';

class TermzillaSSHPageController extends ControllerMVC {
  factory TermzillaSSHPageController([StateMVC? state]) =>
      _this ??= TermzillaSSHPageController._(state);

  TermzillaSSHPageController._(StateMVC? state) : super(state);

  static TermzillaSSHPageController? _this;

  List<TabData> tabs = List.empty(growable: true);
  late TabbedViewController tabbedViewController;
  Map<int, SSHClient> openedSSHClients = HashMap();

  TabbedViewThemeData themeData =
      TabbedViewThemeData.mobile(colorSet: Colors.blueGrey);

  @override
  void initState() {
    super.initState();
    Radius radius = const Radius.circular(10.0);
    BorderRadiusGeometry? borderRadius =
        BorderRadius.only(topLeft: radius, topRight: radius);

    themeData.tabsArea
      ..initialGap = 20
      ..middleGap = 5
      ..minimalFinalGap = 5;
    themeData.tab
      ..padding = const EdgeInsets.only(top: 10)
      ..buttonsOffset = 8
      ..decoration = BoxDecoration(borderRadius: borderRadius);
    tabbedViewController = TabbedViewController(tabs);
  }

  void removeConnectionTab(int indexToRemove) {
    tabs.removeAt(indexToRemove);
    closeConnection(indexToRemove);
    setState(() {});
  }

  void closeConnection(int tabIndex) {
    openedSSHClients[tabIndex]?.close();
    openedSSHClients.remove(tabIndex);
  }

  void setConnectionTab(int index) {
    tabbedViewController.selectedIndex = index;
  }

  Future<void> addConnectionTab(
      ConnectionInfo connectionInfo, BuildContext buildContext) async {
    Terminal terminal = await _initializeTerminal(connectionInfo);

    tabs.add(TabData(
        text: connectionInfo.nameOfTheConnection,
        content: SafeArea(child: TerminalView(terminal)),
        keepAlive: true));

    tabbedViewController.selectedIndex = tabs.length - 1;

    setState(() {});
  }

  Future<Terminal> _initializeTerminal(ConnectionInfo connectionInfo) async {
    final terminal = Terminal();

    final client = SSHClient(
      await SSHSocket.connect(
          connectionInfo.ipAddress, int.tryParse(connectionInfo.port)!),
      username: connectionInfo.username,
      onPasswordRequest: () => connectionInfo.password,
    );

    var title = connectionInfo.ipAddress;

    final session = await client.shell(
      pty: SSHPtyConfig(
        width: terminal.viewWidth,
        height: terminal.viewHeight,
      ),
    );

    terminal.buffer.clear();
    terminal.buffer.setCursor(0, 0);

    terminal.onTitleChange = (title) {
      setState(() => title = title);
    };

    terminal.onResize = (width, height, pixelWidth, pixelHeight) {
      session.resizeTerminal(width, height, pixelWidth, pixelHeight);
    };

    terminal.onOutput = (data) {
      session.write(utf8.encode(data) as Uint8List);
    };

    session.stdout
        .cast<List<int>>()
        .transform(const Utf8Decoder())
        .listen(terminal.write);

    session.stderr
        .cast<List<int>>()
        .transform(const Utf8Decoder())
        .listen(terminal.write);
    return terminal;
  }
}
