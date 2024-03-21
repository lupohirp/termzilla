import 'package:fluent_ui/fluent_ui.dart';

import 'modules/homepage/view/termzilla_homepage.dart';

void main() {
  runApp(const TermzillaApp());
}

class TermzillaApp extends StatelessWidget {
  const TermzillaApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      theme: FluentThemeData(
        accentColor: Colors.blue,
      ),
      home: const TermzillaHomePage(title: 'Termzilla'),
    );
  }
}


