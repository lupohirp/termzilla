import 'dart:async';
import 'dart:convert';

import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/cupertino.dart';
import 'package:xterm/xterm.dart';



class SSHTerminalView extends StatefulWidget {

  final String host;
  final int port;
  final String username;
  final String password;

  SSHTerminalView(this.host, this.port, this.username, this.password);

  @override
  // ignore: library_private_types_in_public_api
  _SSHTerminalViewState createState() => _SSHTerminalViewState();
}

class _SSHTerminalViewState extends State<SSHTerminalView> with AutomaticKeepAliveClientMixin<SSHTerminalView> {

  @override
  bool get wantKeepAlive => true;

  late final terminal = Terminal();

  @override
  void initState() {
    super.initState();
    initTerminal();
  }

  Future<void> initTerminal() async {
    terminal.write('Connecting...\r\n');

    final client = SSHClient(
      await SSHSocket.connect(widget.host, widget.port),
      username: widget.username,
      onPasswordRequest: () => widget.password,
    );

    terminal.write('Connected\r\n');

    final session = await client.shell(
      pty: SSHPtyConfig(
        width: terminal.viewWidth,
        height: terminal.viewHeight,
      ),
    );

    terminal.buffer.clear();
    terminal.buffer.setCursor(0, 0);

    terminal.onResize = (width, height, pixelWidth, pixelHeight) {
      session.resizeTerminal(width, height, pixelWidth, pixelHeight);
    };

    terminal.onOutput = (data) {
      session.write(utf8.encode(data));
    };

    session.stdout
        .cast<List<int>>()
        .transform(Utf8Decoder())
        .listen(terminal.write);

    session.stderr
        .cast<List<int>>()
        .transform(Utf8Decoder())
        .listen(terminal.write);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: [
          Expanded(
            child: TerminalView(terminal),
          )
        ],
      ),
    );
  }
}