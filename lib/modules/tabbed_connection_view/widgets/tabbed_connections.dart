import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:termzilla_renew/modules/tabbed_connection_view/controller/tabbed_connection_view_controller.dart';

class TabbedConnections extends StatefulWidget {
  const TabbedConnections({super.key});

  @override
  State<TabbedConnections> createState() => _TabbedConnectionsState();
}

class _TabbedConnectionsState extends State<TabbedConnections> {
  final ConnectionViewController _connectionViewController =
      Get.put(ConnectionViewController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return TabView(
        currentIndex: _connectionViewController.currentIndex.value,
        tabs: _connectionViewController.tabs!,
        tabWidthBehavior: TabWidthBehavior.equal,
        showScrollButtons: true,
        onChanged: (index) => Obx(()=>_connectionViewController.currentIndex.value = index);
  }
}
