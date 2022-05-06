import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:termzilla/modules/termzilla.connections/controller/termzilla.connections.controller.dart';

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
    return Dialog(
        child: SizedBox(
            height: 500.0,
            width: 800.0,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const Center(child: Text("Add a new connection")),
                actions: [
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close))
                ],
              ),
              body: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ConnectionFormInfo(pageController: _pageController)
                  ]),
            )));
  }
}

class ConnectionFormInfo extends StatelessWidget {
  const ConnectionFormInfo({
    Key? key,
    required TermzillaConnectionsController pageController,
  })  : _pageController = pageController,
        super(key: key);

  final TermzillaConnectionsController _pageController;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: LoaderOverlay(
        child: Form(
          key: _pageController.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: TextFormField(
                    controller: _pageController.nameOfTheConnectionController,
                    validator: FormBuilderValidators.required(
                        errorText: "Please enter a name for the connection"),
                    decoration: const InputDecoration(
                      hintText: 'Name of the connection',
                      helperText: 'Name of the connection',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: TextFormField(
                        controller: _pageController.ipAddressController,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: "Please enter a IPv4 address"),
                          FormBuilderValidators.ip(
                              errorText: "Please enter a valid IPv4 address")
                        ]),
                        decoration: const InputDecoration(
                          hintText: 'IP Address',
                          helperText: 'IP Address',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: TextFormField(
                        controller: _pageController.portController,
                        validator: FormBuilderValidators.numeric(
                            errorText: "Please enter a valid port number"),
                        decoration: const InputDecoration(
                            hintText: '22',
                            helperText: 'Port',
                            border: OutlineInputBorder()),
                      ),
                    ),
                  )
                ]),
              ),
              Row(children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child: TextFormField(
                      controller: _pageController.usernameController,
                      validator: FormBuilderValidators.required(
                          errorText: "Please enter a valid username"),
                      decoration: const InputDecoration(
                        hintText: 'Username',
                        helperText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: !_pageController.shouldUseIdRSA,
                  child: Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: TextFormField(
                        obscureText: true,
                        controller: _pageController.passwordController,
                        decoration: const InputDecoration(
                            hintText: 'Password',
                            helperText: 'Password',
                            border: OutlineInputBorder()),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: _pageController.shouldUseIdRSA,
                  child: Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Password',
                            helperText: 'Password',
                            border: OutlineInputBorder()),
                      ),
                    ),
                  ),
                )
              ]),
              Container(
                margin: const EdgeInsets.only(right: 90, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Checkbox(
                        value: _pageController.shouldUseIdRSA,
                        onChanged: _pageController.onShouldUseIdRSA),
                    const Text(
                      'Select a private key instead of password ',
                      style: TextStyle(fontSize: 17.0),
                    ), //Text
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: 100,
                  height: 40,
                  child: ElevatedButton(
                    child: const Text("Save"),
                    onPressed: () => _pageController.saveConnection(context),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
