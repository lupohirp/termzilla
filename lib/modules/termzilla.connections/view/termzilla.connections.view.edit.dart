import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:termzilla/modules/termzilla.connections/controller/termzilla.connections.controller.dart';
import 'package:termzilla/shared/model/termzilla.connectioninfo.model.dart';

class TermzillaConnectionsEditView extends StatefulWidget {
  final List<ConnectionInfo> _userConnectionInfos;

  const TermzillaConnectionsEditView(
      {Key? key, required List<ConnectionInfo> userConnectionInfos})
      : _userConnectionInfos = userConnectionInfos,
        super(key: key);

  @override
  _TermzillaConnectionsEditViewState createState() =>
      _TermzillaConnectionsEditViewState();
}

class _TermzillaConnectionsEditViewState
    extends StateMVC<TermzillaConnectionsEditView> {
  _TermzillaConnectionsEditViewState()
      : super(TermzillaConnectionsController()) {
    _pageController = controller as TermzillaConnectionsController;
  }

  late TermzillaConnectionsController _pageController;

  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 16, right: 16),
        child: SizedBox(
          width: 200,
          height: 600,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget._userConnectionInfos.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(LineAwesomeIcons.plug,
                    color:
                        index == _selectedIndex ? Colors.white : Colors.black),
                selected: index == _selectedIndex,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(32),
                        bottomRight: Radius.circular(32))),
                selectedTileColor: Colors.blue,
                onTap: () {
                  setState(() {
                    _pageController.textFieldsMustBeEnabled = true;
                    _selectedIndex = index;
                  });
                  _pageController
                      .updateConnection(widget._userConnectionInfos[index]);
                },
                title: Text(
                  widget._userConnectionInfos[index].nameOfTheConnection,
                  style: TextStyle(
                      color: _selectedIndex == index
                          ? Colors.white
                          : Colors.black),
                ),
              );
            },
          ),
        ),
      ),
      ConnectionFormInfo(pageController: _pageController)
    ]);
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
        child: Form(
          key: _pageController.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: TextFormField(
                    onChanged: (value) => _pageController.enableSaveButton(),
                    enabled: _pageController.textFieldsMustBeEnabled,
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
                        onChanged: (value) =>
                            _pageController.enableSaveButton(),
                        enabled: _pageController.textFieldsMustBeEnabled,
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
                        onChanged: (value) =>
                            _pageController.enableSaveButton(),
                        enabled: _pageController.textFieldsMustBeEnabled,
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
                      onChanged: (value) => _pageController.enableSaveButton(),
                      enabled: _pageController.textFieldsMustBeEnabled,
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
                        onChanged: (value) =>
                            _pageController.enableSaveButton(),
                        enabled: _pageController.textFieldsMustBeEnabled,
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
                        onChanged: (value) =>
                            _pageController.enableSaveButton(),
                        enabled: _pageController.textFieldsMustBeEnabled,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: 100,
                      height: 40,
                      child: ElevatedButton(
                        child: const Text("Save"),
                        onPressed: _pageController.saveButtonShouldBeEnabled
                            ? () => _pageController.saveConnection()
                            : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: 100,
                      height: 40,
                      child: ElevatedButton(
                          child: const Text("Delete"),
                          onPressed: () => _pageController.deleteConnection()),
                    ),
                  )
                ],
              )
            ],
          ),
        ),

    );
  }
}
