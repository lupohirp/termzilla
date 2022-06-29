import 'package:fluent_ui/fluent_ui.dart';
import 'package:termzilla/modules/termzilla.connections/controller/termzilla.connections.controller.dart';
import 'package:termzilla/modules/termzilla.connections/view/termzilla.connections.view.add.dart';

class AddConnectionsDialog extends StatelessWidget {
  const AddConnectionsDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: FilledButton(
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return ContentDialog(
                    actions: [
                      FilledButton(
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Save"),
                          ),
                          onPressed: () {
                            TermzillaConnectionsController().saveConnection();
                            const InfoBar(
                              title: Text('Update available'),
                              content: Text(
                                  'Restart the app to apply the latest update.'), // optional
                              severity: InfoBarSeverity
                                  .info, // optional. Default to InfoBarSeverity.info
                            );
                          }),
                    ],
                    constraints: const BoxConstraints(
                        minWidth: 200,
                        maxWidth: 1000,
                        minHeight: 810,
                        maxHeight: 900),
                    title: const Text("Add a new connection"),
                    content: const TermzillaConnectionsAddView());
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(children: const [
              Icon(FluentIcons.add_connection),
              SizedBox(width: 10),
              Text("Add a new connection")
            ]),
          )),
    );
  }
}
