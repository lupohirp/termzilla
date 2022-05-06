import 'dart:collection';

import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:tabbed_view/tabbed_view.dart';
import 'package:termzilla/modules/termzilla.ssh/utils/termzilla.ssh.terminalbackend.dart';
import 'package:termzilla/shared/model/termzilla.connectioninfo.model.dart';
import 'package:xterm/flutter.dart';
import 'package:xterm/terminal/terminal.dart';

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

  void addConnectionTab(
      ConnectionInfo connectionInfo, BuildContext buildContext) {
    tabs.add(TabData(
        text: connectionInfo.nameOfTheConnection,
        content: SafeArea(
            child: TerminalView(
                terminal: Terminal(
                    maxLines: 10000,
                    backend: SSHTerminalBackend(
                        connectionInfo, buildContext, tabs.length)))),
        keepAlive: true));

    tabbedViewController.selectedIndex = tabs.length - 1;

    setState(() {});
  }
}
