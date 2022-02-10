import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:termzilla/modules/termzilla.ssh/view/termzilla.ssh.view.dart';

class TermzillaHomePageController extends ControllerMVC {
  factory TermzillaHomePageController([StateMVC? state]) =>
      _this ??= TermzillaHomePageController._(state);

  TermzillaHomePageController._(StateMVC? state)
      : page = PageController(),
        super(state);

  static TermzillaHomePageController? _this;

  PageController page;

  Widget buildPageController() {
    return PageView(
      controller: page,
      children: [
        const TermzillaSSHPageView(),
        Container(
          color: Colors.white,
          child: Center(
            child: Text(
              'Page\n   2',
              style: TextStyle(fontSize: 35),
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Center(
            child: Text(
              'Page\n   3',
              style: TextStyle(fontSize: 35),
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Center(
            child: Text(
              'Page\n   4',
              style: TextStyle(fontSize: 35),
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Center(
            child: Text(
              'Page\n   5',
              style: TextStyle(fontSize: 35),
            ),
          ),
        ),
      ],
    );
  }
}
