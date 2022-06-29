import 'dart:ffi';

import 'package:fluent_ui/fluent_ui.dart';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:termzilla/modules/termzilla.homepage/controller/termzilla.homepage.controller.dart';
import 'package:termzilla/modules/termzilla.homepage/view/widgets/add_connections_dialog.dart';
import 'package:termzilla/modules/termzilla.homepage/view/widgets/dropdown_flyout_connections_list.dart';
import 'package:termzilla/modules/termzilla.ssh/view/termzilla.ssh.view.dart';

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
    return NavigationView(
      appBar: NavigationAppBar(
          height: 75,
          automaticallyImplyLeading: false,
          actions: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DropDownConnectionsMenuFlyout(pageController: _pageController),
              const AddConnectionsDialog()
            ],
          )),
      content: NavigationBody.builder(
          transitionBuilder: (child, animation) =>
              EntrancePageTransition(child: child, animation: animation),
          index: _pageController.index,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: TermzillaSSHPageView());
            } else {
              return const SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Text("Page 1"));
            }
          }),
      pane: NavigationPane(
        /// The current selected index
        selected: _pageController.index,
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.apps_content),
            title: const Text('Terminal'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.folder_list),
            title: const Text('Files'),
          ),
        ],

        /// Called whenever the current index changes
        onChanged: (i) => setState(() => _pageController.index = i),
        displayMode: PaneDisplayMode.auto,
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(actions: <Widget>[
    //     Padding(
    //       padding: const EdgeInsets.only(right: 30),
    //       child: Row(
    //         children: [
    //           DecoratedBox(
    //             decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.circular(5)),
    //             child: Padding(
    //               padding: const EdgeInsets.only(left: 20, right: 20),
    //               child: DropdownButton<ConnectionInfo>(
    //                 value: _pageController.selectedConnectionInfo,
    //                 underline: const SizedBox(),
    //                 icon: const Icon(LineAwesomeIcons.plug),
    //                 elevation: 16,
    //                 onChanged: (ConnectionInfo? newValue) {
    //                   TermzillaSSHPageController()
    //                       .addConnectionTab(newValue!, context);
    //                 },
    //                 items: _pageController.connectionInfos
    //                     .map<DropdownMenuItem<ConnectionInfo>>(
    //                         (ConnectionInfo connectionInfo) {
    //                   return DropdownMenuItem<ConnectionInfo>(
    //                     value: connectionInfo,
    //                     child: Text(connectionInfo.nameOfTheConnection),
    //                   );
    //                 }).toList(),
    //               ),
    //             ),
    //           ),
    //           const SizedBox(width: 50),
    //           InkWell(
    //             onTap: () {
    //               showDialog(
    //                 context: context,
    //                 builder: (BuildContext context) {
    //                   return const TermzillaConnectionsAddView();
    //                 },
    //               );
    //             },
    //             child: Row(children: const [
    //               Icon(Icons.add),
    //               Text("Add new connection")
    //             ]),
    //           ),
    //           const SizedBox(width: 50),
    //           InkWell(
    //             onTap: () {
    //               showDialog(
    //                 context: context,
    //                 builder: (BuildContext context) {
    //                   return TermzillaConnectionsEditView(
    //                       userConnectionInfos: _pageController.connectionInfos
    //                           .where((element) =>
    //                               element.nameOfTheConnection !=
    //                               "Select a connection")
    //                           .toList());
    //                 },
    //               );
    //             },
    //             child: Row(children: const [
    //               Icon(Icons.edit),
    //               Text("Edit your connections")
    //             ]),
    //           ),
    //         ],
    //       ),
    //     )
    //   ]),
    //   body: Row(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.only(top: 64, left: 24, right: 24),
    //         child: SideMenu(
    //           controller: _pageController.page,
    //           style: SideMenuStyle(
    //             displayMode: SideMenuDisplayMode.auto,
    //             hoverColor: Colors.blue[100],
    //             selectedColor: Theme.of(context).primaryColor,
    //             selectedTitleTextStyle: const TextStyle(color: Colors.white),
    //             iconSize: 24,
    //             selectedIconColor: Colors.white,
    //           ),
    //           items: [
    //             SideMenuItem(
    //               priority: 1,
    //               title: 'Users',
    //               onTap: () {
    //                 _pageController.page.jumpToPage(1);
    //               },
    //               icon: const Icon(Icons.supervisor_account),
    //             ),
    //             SideMenuItem(
    //                 priority: 0,
    //                 title: 'Terminal',
    //                 onTap: () {
    //                   _pageController.page.jumpToPage(0);
    //                 },
    //                 icon: const Icon(LineAwesomeIcons.terminal)),
    //             SideMenuItem(
    //               priority: 2,
    //               title: 'Files',
    //               onTap: () {
    //                 _pageController.page.jumpToPage(2);
    //               },
    //               icon: const Icon(Icons.file_copy_rounded),
    //             ),
    //             SideMenuItem(
    //               priority: 3,
    //               title: 'Download',
    //               onTap: () {
    //                 _pageController.page.jumpToPage(3);
    //               },
    //               icon: const Icon(Icons.download),
    //             ),
    //             SideMenuItem(
    //               priority: 4,
    //               title: 'Settings',
    //               onTap: () {
    //                 _pageController.page.jumpToPage(4);
    //               },
    //               icon: const Icon(Icons.settings),
    //             ),
    //             SideMenuItem(
    //               priority: 6,
    //               title: 'Exit',
    //               onTap: () async {},
    //               icon: const Icon(Icons.exit_to_app),
    //             ),
    //           ],
    //         ),
    //       ),
    //       Expanded(child: _pageController.buildPageController()),
    //     ],
    //   ),
    // );
  }
}
