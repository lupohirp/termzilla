import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:termzilla/modules/termzilla.connections/controller/termzilla.connections.controller.dart';

class TermzillaConnectionsView extends StatefulWidget {
  const TermzillaConnectionsView({Key? key}) : super(key: key);

  @override
  _TermzillaConnectionsViewState createState() =>
      _TermzillaConnectionsViewState();
}

class _TermzillaConnectionsViewState
    extends StateMVC<TermzillaConnectionsView> {
  _TermzillaConnectionsViewState() : super(TermzillaConnectionsController()) {
    _pageController = controller as TermzillaConnectionsController;
  }

  late TermzillaConnectionsController _pageController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 20,
      contentPadding: EdgeInsets.zero,

      content: Builder(builder: ((context) {
        // Get available height and width of the build area of this widget. Make a choice depending on the size.
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;

        return SizedBox(
          height: height - 400,
          width: width - 400,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Add new Connection"),
            ),
            body: Form(
              key: _pageController.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: TextFormField(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: const Text("Submit"),
                      onPressed: () {
                        if (_pageController.formKey.currentState!.validate()) {
                          _pageController.formKey.currentState!.save();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      })),
      // content: Stack(
      //   children: <Widget>[
      //     Positioned(
      //       right: -40.0,
      //       top: -40.0,
      //       child: InkResponse(
      //         onTap: () {
      //           Navigator.of(context).pop();
      //         },
      //         child: const CircleAvatar(
      //           child: Icon(Icons.close),
      //           backgroundColor: Colors.red,
      //         ),
      //       ),
      //     ),
      //     Form(
      //       key: _formKey,
      //       child: Column(
      //         mainAxisSize: MainAxisSize.min,
      //         children: <Widget>[
      //           Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: TextFormField(),
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: TextFormField(),
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: ElevatedButton(
      //               child: const Text("Submit"),
      //               onPressed: () {
      //                 if (_formKey.currentState!.validate()) {
      //                   _formKey.currentState!.save();
      //                 }
      //               },
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
