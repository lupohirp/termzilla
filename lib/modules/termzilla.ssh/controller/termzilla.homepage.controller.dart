import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:termzilla/modules/termzilla.ssh/utils/termzilla.ssh.terminalbackend.dart';
import 'package:xterm/terminal/terminal.dart';

class TermzillaSSHPageController extends ControllerMVC {
  late Terminal terminal;
  late SSHTerminalBackend backend;

  factory TermzillaSSHPageController([StateMVC? state]) =>
      _this ??= TermzillaSSHPageController._(state);

  TermzillaSSHPageController._(StateMVC? state) : super(state);

  static TermzillaSSHPageController? _this;

  @override
  void initState() {
    super.initState();
    backend = SSHTerminalBackend(
        "ssh://10.143.91.16:22", "azureadmin", "Welcome123!");
    terminal = Terminal(backend: backend, maxLines: 10000);
    setState(() {});
  }
}
