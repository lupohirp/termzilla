import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:termzilla/modules/termzilla.homepage/controller/termzilla.homepage.controller.dart';
import 'package:termzilla/shared/const/termzilla.hive.const.dart';
import 'package:termzilla/shared/helper/termzilla.helper.dart';
import 'package:termzilla/shared/model/termzilla.connectioninfo.model.dart';

class TermzillaConnectionsController extends ControllerMVC {
  factory TermzillaConnectionsController([StateMVC? state]) =>
      _this ??= TermzillaConnectionsController._(state);

  TermzillaConnectionsController._(StateMVC? state) : super(state);

  static TermzillaConnectionsController? _this;

  final formKey = GlobalKey<FormState>();

  TextEditingController nameOfTheConnectionController = TextEditingController();

  TextEditingController ipAddressController = TextEditingController();

  TextEditingController portController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController idRsaController = TextEditingController();

  bool shouldUseIdRSA = false;

  void onShouldUseIdRSA(bool? newValue) => setState(() {
        shouldUseIdRSA = newValue!;
      });

  Future<void> saveConnection(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      String nameOfTheConnection = nameOfTheConnectionController.text;
      String ipAddress = ipAddressController.text;
      String port = portController.text;
      String username = usernameController.text;
      String password = passwordController.text;

      if (port.isEmpty) {
        port = "22";
      }

      ConnectionInfo connectionInfo = ConnectionInfo()
        ..ipAddress = ipAddress
        ..nameOfTheConnection = nameOfTheConnection
        ..port = port
        ..username = username
        ..password = password;

      await Hive.openBox<ConnectionInfo>(HiveConst.connectionList,
          encryptionCipher: HiveAesCipher(TermzillaHelper.encryptionKey));
      Box<ConnectionInfo> connectionInfoBox =
          Hive.box<ConnectionInfo>(HiveConst.connectionList);

      await connectionInfoBox.add(connectionInfo);

      await connectionInfoBox.close();

      Navigator.of(context).pop();

      TermzillaHomePageController().triggerReloadStateFromConnectionsView();
    }
  }
}
