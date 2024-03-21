import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:termzilla_renew/modules/tabbed_connection_view/controller/tabbed_connection_view_controller.dart';
import 'package:termzilla_renew/modules/tabbed_connection_view/widgets/tabbed_connections.dart';

import '../widgets/tabbed_connection_view_bottom_bar.dart';

class ConnectionView extends StatelessWidget {
  final ConnectionViewController _connectionViewController =  Get.put(ConnectionViewController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
        bottomBar: const TabbedConnectionViewBottomBar(),
        content: Obx(() => _connectionViewController.tabs.isNotEmpty
            ? const TabbedConnections()
            : Container()));
  }
}
