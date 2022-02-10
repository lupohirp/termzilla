import 'package:flutter/material.dart';
import 'package:termzilla/modules/termzilla.ssh/controller/termzilla.homepage.controller.dart';
import 'package:xterm/frontend/terminal_view.dart';

class PersistantTab extends StatefulWidget {
  const PersistantTab({Key? key}) : super(key: key);

  @override
  _PersistantTabState createState() => _PersistantTabState();
}

class _PersistantTabState extends State<PersistantTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TerminalView(terminal: TermzillaSSHPageController().terminal),
    );
  }

  // Setting to true will force the tab to never be disposed. This could be dangerous.
  @override
  bool get wantKeepAlive => true;
}
