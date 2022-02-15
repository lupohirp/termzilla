import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:termzilla/modules/termzilla.ssh/view/termzilla.ssh.view.dart';
import 'package:termzilla/shared/const/termzilla.hive.const.dart';
import 'package:termzilla/shared/helper/termzilla.helper.dart';
import 'package:termzilla/shared/model/termzilla.connectioninfo.model.dart';

class TermzillaHomePageController extends ControllerMVC {
  factory TermzillaHomePageController([StateMVC? state]) =>
      _this ??= TermzillaHomePageController._(state);

  TermzillaHomePageController._(StateMVC? state)
      : page = PageController(),
        super(state);

  static TermzillaHomePageController? _this;

  PageController page;

  List<ConnectionInfo> connectionInfos = List.empty(growable: true);

  ConnectionInfo selectedConnectionInfo = ConnectionInfo()
    ..nameOfTheConnection = "Select a connection";

  @override
  void initState() {
    /// Look inside the parent function and see it calls
    /// all it's Controllers if any.
    super.initState();
    connectionInfos.add(selectedConnectionInfo);
    _loadPersonalConnections();
  }

  Future<void> triggerReloadStateFromConnectionsView() async {
    connectionInfos.clear();
    connectionInfos.add(selectedConnectionInfo);
    await _loadPersonalConnections();
  }

  Future<void> _loadPersonalConnections() async {
    await Hive.openBox<ConnectionInfo>(HiveConst.connectionList,
        encryptionCipher: HiveAesCipher(TermzillaHelper.encryptionKey));
    Box<ConnectionInfo> connectionInfosBox =
        Hive.box<ConnectionInfo>(HiveConst.connectionList);
    for (var i = 0; i < connectionInfosBox.length; i++) {
      ConnectionInfo connectionInfo = connectionInfosBox.getAt(i)!;
      connectionInfos.add(connectionInfo);
    }

    await connectionInfosBox.close();
    setState(() {});
  }

  Widget buildPageController() {
    return PageView(
      controller: page,
      children: [
        const TermzillaSSHPageView(),
        Container(
          color: Colors.white,
          child: const Center(
            child: Text(
              'Page\n   2',
              style: TextStyle(fontSize: 35),
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: const Center(
            child: Text(
              'Page\n   3',
              style: TextStyle(fontSize: 35),
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: const Center(
            child: Text(
              'Page\n   4',
              style: TextStyle(fontSize: 35),
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: const Center(
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
