//create Singleton class

import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../domain/model/connection.dart';
import '../view/tabbed_connection_view.dart';
import '../widgets/ssh_terminal_view.dart';

class ConnectionViewController extends GetxController {

  //create a list of connections
  List<Connection> connections = List.empty(growable: true);

  //create a list of tabs
  RxList<Tab> tabs = <Tab>[].obs;

  //get current index
  int currentIndex = 0;

  // Change this to a generative constructor
  ConnectionViewController() {
    //add a default tab
    connections.add(Connection("Test Connection", "sshuser", "password", "localhost", 2222));
  }

  //create a list of connection view
  List<Connection> getConnections() {
    return connections;
  }

  //create a list of connection view
  void addConnection(Connection connection) {
    connections.add(connection);

  }

  //create a list of connection view
  void removeConnection(Connection connection) {
    connections.remove(connection);
  }

  //Add a connection
  void addTab(Connection connection) {
    late Tab tab;
    tab = Tab(
      text: Text(connection.name),
      semanticLabel: 'Connection #${connection.name}',
      icon: const Icon(FluentIcons.pc1),
      body: SSHTerminalView(connection.host, connection.port, connection.username, connection.password),
      onClosed: () {
        tabs.remove(tab);
        if (currentIndex > 0) {
          currentIndex--;
        }
      },
    );
    tabs.add(tab);
  }
}
