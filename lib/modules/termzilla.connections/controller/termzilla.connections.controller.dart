import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

  bool saveButtonShouldBeEnabled = false;

  bool textFieldsMustBeEnabled = false;

  ConnectionInfo? connectionInfoToUpdate;

  void onShouldUseIdRSA(bool? newValue) => setState(() {
        saveButtonShouldBeEnabled = true;
        shouldUseIdRSA = newValue!;
      });

  void enableSaveButton() {
    setState(() {
      saveButtonShouldBeEnabled = true;
    });
  }

  @override
  void dispose() {
    connectionInfoToUpdate = null;
    nameOfTheConnectionController.text = "";
    ipAddressController.text = "";
    portController.text = "";
    usernameController.text = "";
    passwordController.text = "";
    super.dispose();
  }

  void updateConnection(ConnectionInfo connectionInfo) {
    nameOfTheConnectionController.text = connectionInfo.nameOfTheConnection;
    ipAddressController.text = connectionInfo.ipAddress!;
    portController.text = connectionInfo.port;
    usernameController.text = connectionInfo.username;
    if (connectionInfo.password != null) {
      passwordController.text = connectionInfo.password!;
    }
    connectionInfoToUpdate = connectionInfo;
  }

  Future<void> deleteConnection() async {
    await Hive.openBox<ConnectionInfo>(HiveConst.connectionList,
        encryptionCipher: HiveAesCipher(TermzillaHelper.encryptionKey));
    Box<ConnectionInfo> connectionInfoBox =
        Hive.box<ConnectionInfo>(HiveConst.connectionList);

    ConnectionInfo? connectionInfoToDelete =
        connectionInfoBox.get(connectionInfoToUpdate!.nameOfTheConnection);

    if (connectionInfoToDelete != null &&
        connectionInfoToDelete.password != null &&
        connectionInfoToDelete.password!.isNotEmpty) {
      const FlutterSecureStorage()
          .delete(key: connectionInfoToDelete.password!);
    }

    await connectionInfoBox.delete(connectionInfoToDelete!.nameOfTheConnection);
    await connectionInfoBox.close();

    Navigator.of(state!.context).pop();

    ScaffoldMessenger.of(TermzillaHomePageController().state!.context)
        .showSnackBar(
            const SnackBar(content: Text("Connection deleted succesfully")));
    await TermzillaHomePageController().triggerReloadStateFromConnectionsView();
  }

  void saveConnection() async {
    if (formKey.currentState!.validate()) {
      if (connectionInfoToUpdate == null) {
        await _saveConnection();
      } else {
        await Hive.openBox<ConnectionInfo>(HiveConst.connectionList,
            encryptionCipher: HiveAesCipher(TermzillaHelper.encryptionKey));

        Box<ConnectionInfo> connectionInfoBox =
            Hive.box<ConnectionInfo>(HiveConst.connectionList);

        for (var i = 0; i < connectionInfoBox.length; i++) {
          ConnectionInfo connectionInfo = connectionInfoBox.getAt(i)!;
          if (connectionInfo.nameOfTheConnection ==
              connectionInfoToUpdate?.nameOfTheConnection) {
            await _updateThatConnection(connectionInfo, connectionInfoBox);
            break;
          }
        }
      }

      Navigator.of(state!.context).pop();
      TermzillaHomePageController().displayInfoBar("success");
      await TermzillaHomePageController()
          .triggerReloadStateFromConnectionsView();
    }
  }

  Future<void> _updateThatConnection(ConnectionInfo connectionInfo,
      Box<ConnectionInfo> connectionInfoBox) async {
    connectionInfo.ipAddress = ipAddressController.text;
    connectionInfo.nameOfTheConnection = nameOfTheConnectionController.text;
    if (passwordController.text.isNotEmpty) {
      await const FlutterSecureStorage()
          .write(key: connectionInfo.password!, value: passwordController.text);
    }
    connectionInfo.port = portController.text;
    connectionInfo.username = usernameController.text;
    connectionInfo.rsakey = "";
    await connectionInfoBox.put(
        connectionInfo.nameOfTheConnection, connectionInfo);
    await connectionInfoBox.close();
  }

  Future<void> _saveConnection() async {
    String nameOfTheConnection = nameOfTheConnectionController.text;
    String ipAddress = ipAddressController.text;
    String port = portController.text;
    String username = usernameController.text;
    String? password;
    if (passwordController.text.isNotEmpty) {
      password = Uuid().generateV4();

      await const FlutterSecureStorage()
          .write(key: password, value: passwordController.text);
    }

    if (port.isEmpty) {
      port = "22";
    }

    ConnectionInfo connectionInfo = ConnectionInfo()
      ..ipAddress = ipAddress
      ..nameOfTheConnection = nameOfTheConnection
      ..port = port
      ..username = username
      ..password = password
      ..rsakey = "";

    await Hive.openBox<ConnectionInfo>(HiveConst.connectionList,
        encryptionCipher: HiveAesCipher(TermzillaHelper.encryptionKey));
    Box<ConnectionInfo> connectionInfoBox =
        Hive.box<ConnectionInfo>(HiveConst.connectionList);

    await connectionInfoBox.put(
        connectionInfo.nameOfTheConnection, connectionInfo);

    await connectionInfoBox.close();
  }
}
