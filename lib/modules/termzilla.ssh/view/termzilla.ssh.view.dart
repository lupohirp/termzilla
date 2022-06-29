import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:termzilla/modules/termzilla.ssh/controller/termzilla.ssh.controller.dart';

class TermzillaSSHPageView extends StatefulWidget {
  const TermzillaSSHPageView({Key? key}) : super(key: key);

  @override
  _TermzillaSSHPageViewState createState() => _TermzillaSSHPageViewState();
}

class _TermzillaSSHPageViewState extends StateMVC<TermzillaSSHPageView> {
  _TermzillaSSHPageViewState() : super(TermzillaSSHPageController()) {
    _pageController = controller as TermzillaSSHPageController;
  }

  late TermzillaSSHPageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Container();
    // return TabView(
    //     child: TabbedView(
    //         controller: _pageController.tabbedViewController,
    //         onTabClose: (tabIndex, tabData) =>
    //             _pageController.closeConnection(tabIndex)),
    //     data: _pageController.themeData);
  }
}
