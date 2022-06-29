import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dartssh2/dartssh2.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'package:termzilla/shared/model/termzilla.connectioninfo.model.dart';

class TermzillaSSHPageController extends ControllerMVC {
  factory TermzillaSSHPageController([StateMVC? state]) =>
      _this ??= TermzillaSSHPageController._(state);

  TermzillaSSHPageController._(StateMVC? state) : super(state);

  static TermzillaSSHPageController? _this;

  Map<int, SSHClient> openedSSHClients = HashMap();

  int currentIndex = 0;

  List<Tab>? tabs;
  List<Widget>? bodies;

  @override
  void initState() {
    super.initState();
    tabs ??= List.generate(3, (index) {
      late Tab tab;
      tab = Tab(
        text: Text('Document $index'),
        semanticLabel: 'Document #$index',
        onClosed: () => tabs!.remove(tab),
      );
      return tab;
    });
    bodies ??= List.generate(3, (index) {
      return Container(
        color:
            Colors.accentColors[Random().nextInt(Colors.accentColors.length)],
      );
    });
  }

  void removeConnectionTab(int indexToRemove) {
    //tabs.removeAt(indexToRemove);
    closeConnection(indexToRemove);
    setState(() {});
  }

  void closeConnection(int tabIndex) {
    openedSSHClients[tabIndex]?.close();
    openedSSHClients.remove(tabIndex);
  }

  // Future<void> addConnectionTab(
  //     ConnectionInfo connectionInfo, BuildContext buildContext) async {
  //   Terminal terminal = Terminal();
  //   SSHSession? session =
  //       await _connectToRemoteMachineWithSSH(connectionInfo, terminal);
  //
  //   if (session != null) {
  //     _initializeTerminal(connectionInfo, terminal, session);
  //     tabs.add(TabData(
  //         text: connectionInfo.nameOfTheConnection,
  //         content: SafeArea(child: TerminalView(terminal)),
  //         keepAlive: true));
  //
  //     tabbedViewController.selectedIndex = tabs.length - 1;
  //
  //     setState(() {});
  //   }
  // }

  // void _initializeTerminal(
  //     ConnectionInfo connectionInfo, Terminal terminal, SSHSession? session) {
  //   terminal.buffer.clear();
  //   terminal.buffer.setCursor(0, 0);
  //
  //   terminal.onTitleChange = (title) {
  //     setState(() => title = title);
  //   };
  //
  //   terminal.onResize = (width, height, pixelWidth, pixelHeight) {
  //     session?.resizeTerminal(width, height, pixelWidth, pixelHeight);
  //   };
  //
  //   terminal.onOutput = (data) {
  //     session?.write(utf8.encode(data) as Uint8List);
  //   };
  //
  //   session?.stdout
  //       .cast<List<int>>()
  //       .transform(const Utf8Decoder())
  //       .listen(terminal.write);
  //
  //   session?.stderr
  //       .cast<List<int>>()
  //       .transform(const Utf8Decoder())
  //       .listen(terminal.write);
  // }

  // Future<SSHSession?> _connectToRemoteMachineWithSSH(
  //     ConnectionInfo connectionInfo, Terminal terminal) async {
  //   ProgressDialog pd = ProgressDialog(
  //     context: state!.context,
  //     backgroundColor: Colors.white,
  //     textColor: Colors.black,
  //     loadingText: "Trying to connect to ${connectionInfo.ipAddress!}",
  //   );
  //   try {
  //     pd.show();
  //     final client = SSHClient(
  //       await SSHSocket.connect(
  //           connectionInfo.ipAddress!, int.tryParse(connectionInfo.port)!),
  //       username: connectionInfo.username,
  //       onPasswordRequest: () => connectionInfo.password,
  //     );
  //
  //     var title = connectionInfo.ipAddress;
  //
  //     final session = await client.shell(
  //       pty: SSHPtyConfig(
  //         width: terminal.viewWidth,
  //         height: terminal.viewHeight,
  //       ),
  //     );
  //     pd.dismiss();
  //     return session;
  //   } on SocketException catch (e) {
  //     pd.dismiss();
  //     _handleTimeoutException(connectionInfo);
  //   } on SSHAuthFailError catch (e) {
  //     pd.dismiss();
  //     _handleTimeoutException(connectionInfo);
  //   }
  //   return null;
  // }

  // void _handleTimeoutException(ConnectionInfo connectionInfo) {
  //   showDialog(
  //       context: state!.context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           actions: [
  //             ElevatedButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: const Text("OK"))
  //           ],
  //           content: Row(children: [
  //             const Icon(LineAwesomeIcons.unlink),
  //             const SizedBox(
  //               width: 50,
  //             ),
  //             Text(
  //                 "Unable to connect to ${connectionInfo.ipAddress}. Please check if the address or port is correct or it is up and running")
  //           ]),
  //         );
  //       });
  // }
}
