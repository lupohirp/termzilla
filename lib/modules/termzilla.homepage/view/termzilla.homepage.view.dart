import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:termzilla/modules/termzilla.homepage/controller/termzilla.homepage.controller.dart';

class TermzillaHomePageView extends StatefulWidget {
  const TermzillaHomePageView({Key? key}) : super(key: key);

  @override
  _TermzillaHomePageViewState createState() => _TermzillaHomePageViewState();
}

class _TermzillaHomePageViewState extends StateMVC<TermzillaHomePageView> {
  _TermzillaHomePageViewState() : super(TermzillaHomePageController()) {
    _pageController = controller as TermzillaHomePageController;
  }

  late TermzillaHomePageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.settings),
          tooltip: 'Settings',
          onPressed: () {
            Navigator.push(context, MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Next page'),
                  ),
                  body: const Center(
                    child: Text(
                      'This is the next page',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                );
              },
            ));
          },
        )
      ]),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 64, left: 24, right: 24),
            child: SideMenu(
              controller: _pageController.page,
              style: SideMenuStyle(
                displayMode: SideMenuDisplayMode.auto,
                hoverColor: Colors.blue[100],
                selectedColor: Theme.of(context).primaryColor,
                selectedTitleTextStyle: TextStyle(color: Colors.white),
                selectedIconColor: Colors.white,
              ),
              items: [
                SideMenuItem(
                  priority: 0,
                  title: 'Terminal',
                  onTap: () {
                    _pageController.page.jumpToPage(0);
                  },
                  icon: Icons.terminal,
                ),
                SideMenuItem(
                  priority: 1,
                  title: 'Users',
                  onTap: () {
                    _pageController.page.jumpToPage(1);
                  },
                  icon: Icons.supervisor_account,
                ),
                SideMenuItem(
                  priority: 2,
                  title: 'Files',
                  onTap: () {
                    _pageController.page.jumpToPage(2);
                  },
                  icon: Icons.file_copy_rounded,
                ),
                SideMenuItem(
                  priority: 3,
                  title: 'Download',
                  onTap: () {
                    _pageController.page.jumpToPage(3);
                  },
                  icon: Icons.download,
                ),
                SideMenuItem(
                  priority: 4,
                  title: 'Settings',
                  onTap: () {
                    _pageController.page.jumpToPage(4);
                  },
                  icon: Icons.settings,
                ),
                SideMenuItem(
                  priority: 6,
                  title: 'Exit',
                  onTap: () async {},
                  icon: Icons.exit_to_app,
                ),
              ],
            ),
          ),
          Expanded(child: _pageController.buildPageController()),
        ],
      ),
    );
  }
}
