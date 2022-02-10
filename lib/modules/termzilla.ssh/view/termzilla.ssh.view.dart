import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:termzilla/modules/termzilla.ssh/controller/termzilla.homepage.controller.dart';
import 'package:termzilla/modules/termzilla.ssh/utils/termzila.ssh.persistenttab.dart';
import 'package:xterm/frontend/terminal_view.dart';

class TermzillaSSHPageView extends StatefulWidget {
  const TermzillaSSHPageView({Key? key}) : super(key: key);

  @override
  _TermzillaSSHPageViewState createState() => _TermzillaSSHPageViewState();
}

class _TermzillaSSHPageViewState extends StateMVC<TermzillaSSHPageView> {
  _TermzillaSSHPageViewState() : super(TermzillaSSHPageController());

  @override
  Widget build(BuildContext context) {
    return const PersistantTab();
  }
}
