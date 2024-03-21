import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:termzilla_renew/modules/tabbed_connection_view/view/tabbed_connection_view.dart';

import '../../../domain/model/connection.dart';
import '../controller/tabbed_connection_view_controller.dart';

class UserConnectionsDialog extends StatelessWidget {
  const UserConnectionsDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    late Connection selectedConnection;

    ConnectionViewController _connectionViewController = Get.put(ConnectionViewController(), permanent: true);

    return ContentDialog(
      constraints: const BoxConstraints(
        maxHeight: 185,
        maxWidth: 375,
      ),
      title: const Text('Choose a connection'),
      content: AutoSuggestBox<String>(
          items: _connectionViewController.connections.map((connection) {
            return AutoSuggestBoxItem<String>(
                value: connection.name,
                label: "${connection.name} - ${connection.host}:${connection.port}"
            );
          }).toList(),
        onSelected: (value) {
          selectedConnection = _connectionViewController.connections.firstWhere((element) => element.name == value.value);
        },
      ),
      actions: [
        Button(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FilledButton(
          focusable: false,
          child: const Text('Connect'),
          onPressed: () => {
            _connectionViewController.addTab(selectedConnection),
            Navigator.pop(context)
          },
        ),
      ],
    );
  }
}