import 'package:fluent_ui/fluent_ui.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:termzilla/modules/termzilla.connections/controller/termzilla.connections.controller.dart';

class ConnectionForm extends StatelessWidget {
  const ConnectionForm({
    Key? key,
    required TermzillaConnectionsController pageController,
  })  : _pageController = pageController,
        super(key: key);

  final TermzillaConnectionsController _pageController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _pageController.formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormBox(
              controller: _pageController.nameOfTheConnectionController,
              validator: FormBuilderValidators.required(
                  errorText: "Please enter a name for the connection"),
              header: "Connection Name",
              placeholder: "Set a name for this connection",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormBox(
                controller: _pageController.ipAddressController,
                header: "Machine Address",
                placeholder: "Set an address for this connection",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter an address";
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormBox(
                controller: _pageController.portController,
                header: "Port",
                placeholder: "Set the port (leave blank for 22)",
                validator: FormBuilderValidators.numeric(
                    errorText: "Please enter a valid port number")),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormBox(
              controller: _pageController.usernameController,
              validator: FormBuilderValidators.required(
                  errorText: "Please enter a  username"),
              header: "Username",
              placeholder: "Username",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Visibility(
              visible: !_pageController.shouldUseIdRSA,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormBox(
                  obscureText: true,
                  controller: _pageController.passwordController,
                  validator: FormBuilderValidators.required(
                      errorText: "Please enter a password"),
                  header: "Password",
                  placeholder: "Password",
                ),
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Visibility(
                    visible: _pageController.shouldUseIdRSA,
                    child: FilledButton(
                      child: const Text("Choose public key"),
                      onPressed: () => {},
                    ),
                  ),
                ),
                const Spacer(),
                Checkbox(
                    checked: _pageController.shouldUseIdRSA,
                    onChanged: _pageController.onShouldUseIdRSA),
                const Text(
                  'Select a private key instead of password ',
                  style: TextStyle(fontSize: 17.0),
                ), //Text
              ],
            ),
          ),
        ],
      ),
    );
  }
}
