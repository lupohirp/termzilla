import 'dart:convert';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluent_ui/src/styles/theme.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:termzilla/modules/termzilla.homepage/view/termzilla.homepage.view.dart';
import 'package:termzilla/shared/helper/termzilla.helper.dart';
import 'package:termzilla/shared/model/termzilla.connectioninfo.model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _initializeHive();

  TermzillaHelper.encryptionKey =
      base64Url.decode(const String.fromEnvironment("HIVE_KEY"));

  runApp(const TermzillaApp());
}

class TermzillaApp extends StatelessWidget {
  const TermzillaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Termzilla',
      theme: ThemeData(accentColor: Colors.blue),
      home: const TermzillaHomePageView(),
    );
  }
}

Future<void> _initializeHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ConnectionInfoAdapter());
}
