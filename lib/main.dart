import 'package:flutter/material.dart';

import 'package:termzilla/modules/termzilla.homepage/view/termzilla.homepage.view.dart';

void main() {
  runApp(const TermzillaApp());
}

class TermzillaApp extends StatelessWidget {
  const TermzillaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Termzilla',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TermzillaHomePageView(),
    );
  }
}
