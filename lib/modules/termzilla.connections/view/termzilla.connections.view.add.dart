import 'package:fluent_ui/fluent_ui.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:termzilla/modules/termzilla.connections/controller/termzilla.connections.controller.dart';
import 'package:termzilla/modules/termzilla.connections/view/widget/common/termzilla.connection.common.dart';

class TermzillaConnectionsAddView extends StatefulWidget {
  const TermzillaConnectionsAddView({Key? key}) : super(key: key);

  @override
  _TermzillaConnectionsAddViewState createState() =>
      _TermzillaConnectionsAddViewState();
}

class _TermzillaConnectionsAddViewState
    extends StateMVC<TermzillaConnectionsAddView> {
  _TermzillaConnectionsAddViewState()
      : super(TermzillaConnectionsController()) {
    _pageController = controller as TermzillaConnectionsController;
  }

  late TermzillaConnectionsController _pageController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(70.0),
      child: ConnectionForm(pageController: _pageController),
    );
  }
}
