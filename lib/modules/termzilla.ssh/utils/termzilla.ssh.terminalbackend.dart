import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:xterm/xterm.dart';
import 'package:dartssh2/dartssh2.dart';

class SSHTerminalBackend extends TerminalBackend {
  late SSHClient client;

  String _host;
  String _username;
  String _password;

  final _exitCodeCompleter = Completer<int>();
  final _outStream = StreamController<String>();

  SSHTerminalBackend(this._host, this._username, this._password);

  void onWrite(String data) {
    _outStream.sink.add(data);
  }

  @override
  Future<int> get exitCode => _exitCodeCompleter.future;

  @override
  Stream<String> get out => _outStream.stream;
  late SSHSession shell;
  @override
  void init() async {
    // Use utf8.decoder to handle broken utf8 chunks
    final _sshOutput = StreamController<List<int>>();
    _sshOutput.stream.transform(utf8.decoder).listen(onWrite);

    onWrite('connecting $_host...');
    client = SSHClient(await SSHSocket.connect('10.143.91.16', 22),
        username: 'azureadmin',
        onPasswordRequest: () => 'Welcome123!',
        onAuthenticated: () => onWrite("connected"));
    shell = await client.shell();
    _sshOutput.addStream(shell.stdout); // listening for stdout
    _sshOutput.addStream(shell.stderr); // listening for stderr

    // client = SSHClient(
    //   hostport: Uri.parse(_host),
    //   username: _username,
    //   print: print,
    //   termWidth: 80,
    //   termHeight: 25,
    //   termvar: 'xterm-256color',
    //   onPasswordRequest: () => _password,
    //   response: (data) {
    //     _sshOutput.add(data);
    //   },
    //   success: () {
    //     onWrite('connected.\n');
    //   },
    //   disconnected: () {
    //     onWrite('disconnected.');
    //     _outStream.close();
    //   },
    // );
  }

  @override
  void ackProcessed() {
    // TODO: implement ackProcessed
  }

  @override
  void resize(int width, int height, int pixelWidth, int pixelHeight) {
    shell.resizeTerminal(width, height, pixelWidth, pixelHeight);
  }

  @override
  void terminate() {
    shell.close();
  }

  @override
  void write(String input) {
    shell.write(Uint8List.fromList(utf8.encode(input)));
  }
}
