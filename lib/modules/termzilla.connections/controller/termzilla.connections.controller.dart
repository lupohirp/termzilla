import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
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

  ConnectionInfo? connectionInfoToUpdate;

  void onShouldUseIdRSA(bool? newValue) => setState(() {
        shouldUseIdRSA = newValue!;
      });

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

  updateConnection(ConnectionInfo connectionInfo) {
    nameOfTheConnectionController.text = connectionInfo.nameOfTheConnection;
    ipAddressController.text = connectionInfo.ipAddress;
    portController.text = connectionInfo.port;
    usernameController.text = connectionInfo.username;
    passwordController.text = connectionInfo.password!;

    connectionInfoToUpdate = connectionInfo;
  }

  Future<void> saveConnection(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      context.loaderOverlay.show();
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
            await _updateThatConnection(connectionInfo, connectionInfoBox, i);
            break;
          }
        }
      }
      context.loaderOverlay.hide();

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Connection saved succesfully")));

      Navigator.of(context).pop();

      await TermzillaHomePageController()
          .triggerReloadStateFromConnectionsView();
    }
  }

  Future<void> _updateThatConnection(ConnectionInfo connectionInfo,
      Box<ConnectionInfo> connectionInfoBox, int i) async {
    connectionInfo.ipAddress = ipAddressController.text;
    connectionInfo.nameOfTheConnection = nameOfTheConnectionController.text;
    if (passwordController.text.isNotEmpty) {
      await const FlutterSecureStorage()
          .write(key: connectionInfo.password!, value: passwordController.text);
    }
    connectionInfo.port = portController.text;
    connectionInfo.username = usernameController.text;
    connectionInfo.rsakey = "";
    await connectionInfoBox.putAt(i, connectionInfo);
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

    await connectionInfoBox.add(connectionInfo);

    await connectionInfoBox.close();
  }
}
