import 'dart:math';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:termzilla/modules/termzilla.ssh/controller/termzilla.ssh.controller.dart';

class TermzillaSSHPageView extends StatefulWidget {
  const TermzillaSSHPageView({Key? key}) : super(key: key);

  @override
  _TermzillaSSHPageViewState createState() => _TermzillaSSHPageViewState();
}

class _TermzillaSSHPageViewState extends StateMVC<TermzillaSSHPageView> {
  _TermzillaSSHPageViewState() : super(TermzillaSSHPageController()) {
    _pageController = controller as TermzillaSSHPageController;
  }

  late TermzillaSSHPageController _pageController;

  @override
  Widget build(BuildContext context) {
    return TabView(
      tabs: _pageController.tabs!,
      bodies: _pageController.bodies!,
      currentIndex: _pageController.currentIndex,
      onChanged: (index) =>
          setState(() => _pageController.currentIndex = index),
      onNewPressed: () {
        setState(() {
          late Tab tab;
          final index = _pageController.tabs!.length + 1;
          tab = Tab(
            text: Text('Document $index'),
            semanticLabel: 'Document #$index',
            onClosed: () => _pageController.tabs!.remove(tab),
          );
          _pageController.tabs!.add(tab);
          _pageController.bodies!.add(Container(
            color: Colors
                .accentColors[Random().nextInt(Colors.accentColors.length)],
          ));
        });
      },
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = _pageController.tabs!.removeAt(oldIndex);
          final body = _pageController.bodies!.removeAt(oldIndex);

          _pageController.tabs!.insert(newIndex, item);
          _pageController.bodies!.insert(newIndex, body);

          if (_pageController.currentIndex == newIndex) {
            _pageController.currentIndex = oldIndex;
          } else if (_pageController.currentIndex == oldIndex) {
            _pageController.currentIndex = newIndex;
          }
        });
      },
    );
    // return TabView(
    //     child: TabbedView(
    //         controller: _pageController.tabbedViewController,
    //         onTabClose: (tabIndex, tabData) =>
    //             _pageController.closeConnection(tabIndex)),
    //     data: _pageController.themeData);
  }
}
