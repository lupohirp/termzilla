import 'package:fluent_ui/fluent_ui.dart';
import 'package:termzilla_renew/modules/tabbed_connection_view/widgets/connect_button.dart';

class TabbedConnectionViewBottomBar extends StatelessWidget {

  const TabbedConnectionViewBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        color: Colors.blue,
        child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: ConnectButton(),
            )));
  }
}


