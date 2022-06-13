import 'package:fluent_ui/fluent_ui.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:termzilla/modules/termzilla.connections/controller/termzilla.connections.controller.dart';
import 'package:termzilla/modules/termzilla.connections/view/termzilla.connections.view.add.dart';
import 'package:termzilla/modules/termzilla.connections/view/termzilla.connections.view.edit.dart';
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
    return NavigationView(
      appBar: NavigationAppBar(
          height: 75,
          automaticallyImplyLeading: false,
          actions: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: FilledButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return ContentDialog(
                              actions: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FilledButton(
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Save"),
                                      ),
                                      onPressed: () =>
                                          TermzillaConnectionsController()
                                              .saveConnection()),
                                )
                              ],
                              constraints: const BoxConstraints(
                                  minWidth: 200,
                                  maxWidth: 1000,
                                  minHeight: 200,
                                  maxHeight: 800),
                              title: const Text("Add a new connection"),
                              content: const TermzillaConnectionsAddView());
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(children: const [
                        Icon(FluentIcons.add_connection),
                        SizedBox(width: 10),
                        Text("Add a new connection")
                      ]),
                    )),
              )
            ],
          )),
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
