import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:legacy_progress_dialog/legacy_progress_dialog.dart';

import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
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
    Terminal terminal = Terminal();
    SSHSession? session =
        await _connectToRemoteMachineWithSSH(connectionInfo, terminal);

    if (session != null) {
      _initializeTerminal(connectionInfo, terminal, session);
      tabs.add(TabData(
          text: connectionInfo.nameOfTheConnection,
          content: SafeArea(child: TerminalView(terminal)),
          keepAlive: true));

      tabbedViewController.selectedIndex = tabs.length - 1;

      setState(() {});
    }
  }

  void _initializeTerminal(
      ConnectionInfo connectionInfo, Terminal terminal, SSHSession? session) {
    terminal.buffer.clear();
    terminal.buffer.setCursor(0, 0);

    terminal.onTitleChange = (title) {
      setState(() => title = title);
    };

    terminal.onResize = (width, height, pixelWidth, pixelHeight) {
      session?.resizeTerminal(width, height, pixelWidth, pixelHeight);
    };

    terminal.onOutput = (data) {
      session?.write(utf8.encode(data) as Uint8List);
    };

    session?.stdout
        .cast<List<int>>()
        .transform(const Utf8Decoder())
        .listen(terminal.write);

    session?.stderr
        .cast<List<int>>()
        .transform(const Utf8Decoder())
        .listen(terminal.write);
  }

  Future<SSHSession?> _connectToRemoteMachineWithSSH(
      ConnectionInfo connectionInfo, Terminal terminal) async {
    ProgressDialog pd = ProgressDialog(
      context: state!.context,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      loadingText: "Trying to connect to ${connectionInfo.ipAddress}",
    );
    try {
      pd.show();
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
      pd.dismiss();
      return session;
    } on SocketException catch (e) {
      pd.dismiss();
      _handleTimeoutException(connectionInfo);
    } on SSHAuthFailError catch (e) {
      pd.dismiss();
      _handleTimeoutException(connectionInfo);
    }
    return null;
  }

  void _handleTimeoutException(ConnectionInfo connectionInfo) {
    showDialog(
        context: state!.context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"))
            ],
            content: Row(children: [
              const Icon(LineAwesomeIcons.unlink),
              const SizedBox(
                width: 50,
              ),
              Text(
                  "Unable to connect to ${connectionInfo.ipAddress}. Please check if the address or port is correct or it is up and running")
            ]),
          );
        });
  }
}
