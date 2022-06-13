import 'package:fluent_ui/fluent_ui.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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
    return Padding(
      padding: const EdgeInsets.all(70.0),
      child: Form(
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
                header: "IPv4 Address",
                placeholder: "Set an IPv4 address for this connection",
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: "Please enter a IPv4 address"),
                  FormBuilderValidators.ip(
                      errorText: "Please enter a valid IPv4 address")
                ]),
              ),
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

            // Padding(
            //   padding: const EdgeInsets.only(bottom: 16),
            //   child: Row(children: [
            //     Flexible(
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 36),
            //         child: TextFormField(
            //           controller: _pageController.ipAddressController,
            //           validator: FormBuilderValidators.compose([
            //             FormBuilderValidators.required(
            //                 errorText: "Please enter a IPv4 address"),
            //             FormBuilderValidators.ip(
            //                 errorText: "Please enter a valid IPv4 address")
            //           ]),
            //           decoration: const InputDecoration(
            //             hintText: 'IP Address',
            //             helperText: 'IP Address',
            //             border: OutlineInputBorder(),
            //           ),
            //         ),
            //       ),
            //     ),
            //     Flexible(
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 36),
            //         child: TextFormField(
            //           controller: _pageController.portController,
            //           validator: FormBuilderValidators.numeric(
            //               errorText: "Please enter a valid port number"),
            //           decoration: const InputDecoration(
            //               hintText: '22',
            //               helperText: 'Port',
            //               border: OutlineInputBorder()),
            //         ),
            //       ),
            //     )
            //   ]),
            // ),
            // Row(children: [
            //   Flexible(
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 36),
            //       child: TextFormField(
            //         controller: _pageController.usernameController,
            //         validator: FormBuilderValidators.required(
            //             errorText: "Please enter a valid username"),
            //         decoration: const InputDecoration(
            //           hintText: 'Username',
            //           helperText: 'Username',
            //           border: OutlineInputBorder(),
            //         ),
            //       ),
            //     ),
            //   ),
            //   Visibility(
            //     visible: !_pageController.shouldUseIdRSA,
            //     child: Flexible(
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 36),
            //         child: TextFormField(
            //           obscureText: true,
            //           controller: _pageController.passwordController,
            //           decoration: const InputDecoration(
            //               hintText: 'Password',
            //               helperText: 'Password',
            //               border: OutlineInputBorder()),
            //         ),
            //       ),
            //     ),
            //   ),
            //   Visibility(
            //     visible: _pageController.shouldUseIdRSA,
            //     child: Flexible(
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 36),
            //         child: TextFormField(
            //           decoration: const InputDecoration(
            //               hintText: 'Password',
            //               helperText: 'Password',
            //               border: OutlineInputBorder()),
            //         ),
            //       ),
            //     ),
            //   )
            // ]),
            // Container(
            //   margin: const EdgeInsets.only(right: 90, top: 10),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       Checkbox(
            //           value: _pageController.shouldUseIdRSA,
            //           onChanged: _pageController.onShouldUseIdRSA),
            //       const Text(
            //         'Select a private key instead of password ',
            //         style: TextStyle(fontSize: 17.0),
            //       ), //Text
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child: SizedBox(
            //     width: 100,
            //     height: 40,
            //     child: ElevatedButton(
            //       child: const Text("Save"),
            //       onPressed: () => _pageController.saveConnection(),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
