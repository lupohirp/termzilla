import 'package:fluent_ui/fluent_ui.dart';
import 'package:termzilla_renew/modules/tabbed_connection_view/view/tabbed_connection_view.dart';
import '../../tabbed_connection_view/controller/tabbed_connection_view_controller.dart';

class TermzillaHomePage extends StatefulWidget {
  const TermzillaHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TermzillaHomePage> createState() => _TermzillaHomePageState();
}

class _TermzillaHomePageState extends State<TermzillaHomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      pane: NavigationPane(
          displayMode: PaneDisplayMode.compact,
          selected: index,
          onChanged: (i) => setState(() => index = i),
          items: [
            PaneItem(
                icon: const Icon(FluentIcons.pc1),
                title: const Text("Connections"),
                body: ConnectionView()),
            PaneItemSeparator(),
            PaneItem(
                icon: const Icon(FluentIcons.pc1),
                title: const Text("Insert"),
                body: Container(
                  child: Text("INSERT"),
                )),
            PaneItem(
                icon: const Icon(FluentIcons.view),
                title: const Text("View"),
                body: Container(
                  child: Text("VIEW"),
                )),
          ]),
      appBar: NavigationAppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text(widget.title, style: FluentTheme.of(context).typography.title),
          ],
        ),
      ),
    );
  }
}
