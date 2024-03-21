import 'package:fluent_ui/fluent_ui.dart';
import 'package:termzilla_renew/modules/tabbed_connection_view/controller/tabbed_connection_view_controller.dart';

import 'user_connections_dialog.dart';

class ConnectButton extends StatelessWidget {
  const ConnectButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {


    return Button(
        style: ButtonStyle(
            shape: ButtonState.resolveWith((states) =>
            const RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(0)))),
            backgroundColor: ButtonState.resolveWith(
                    (states) => Colors.transparent)),
        onPressed: () => showDialog<String>(
            context: context,
            builder: (context) => const UserConnectionsDialog()),
        child: const Column(
          children: [
            Icon(FluentIcons.add_connection, color: Colors.white),
            Padding(
                padding:
                EdgeInsetsDirectional.symmetric(vertical: 3.5)),
            Text("Connect",
                style: TextStyle(color: Colors.white)),
          ],
        ));
  }
}

