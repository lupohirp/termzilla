import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:legacy_progress_dialog/legacy_progress_dialog.dart';
import 'package:termzilla/shared/model/termzilla.connectioninfo.model.dart';
import 'package:xterm/xterm.dart';
import 'package:dartssh2/dartssh2.dart';

class SSHTerminalBackend extends TerminalBackend {
  late SSHClient client;
  ConnectionInfo _connectionInfo;
  BuildContext _parentBuildContext;

  final _exitCodeCompleter = Completer<int>();
  final _outStream = StreamController<String>();

  SSHTerminalBackend(
      ConnectionInfo connectionInfo, BuildContext parentBuildContext)
      : _connectionInfo = connectionInfo,
        _parentBuildContext = parentBuildContext;

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

    ProgressDialog pd = ProgressDialog(
      context: _parentBuildContext,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      loadingText: "Trying to connect to ${_connectionInfo.ipAddress}",
    );
    pd.show();
    try {
      client = SSHClient(
          await SSHSocket.connect(
              _connectionInfo.ipAddress, int.parse(_connectionInfo.port),
              timeout: const Duration(seconds: 15)),
          username: _connectionInfo.username,
          onPasswordRequest: () => _connectionInfo.password,
          onAuthenticated: () => pd.dismiss());
      shell = await client.shell();
    } on SocketException catch (e) {
      pd.dismiss();
    }

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
    //  shell.resizeTerminal(width, height, pixelWidth, pixelHeight);
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
