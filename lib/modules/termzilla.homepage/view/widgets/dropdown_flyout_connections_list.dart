import 'package:fluent_ui/fluent_ui.dart';
import 'package:termzilla/modules/termzilla.homepage/controller/termzilla.homepage.controller.dart';
import 'package:termzilla/shared/model/termzilla.connectioninfo.model.dart';

class DropDownConnectionsMenuFlyout extends StatelessWidget {
  const DropDownConnectionsMenuFlyout({
    Key? key,
    required TermzillaHomePageController pageController,
  })  : _pageController = pageController,
        super(key: key);

  final TermzillaHomePageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Flyout(
        controller: _pageController.flyoutController,
        child: FilledButton(
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Select a Connection"),
            ),
            onPressed: _pageController.flyoutController.open),
        content: (context) {
          return MenuFlyout(
              items: _pageController.connectionInfos
                  .map((ConnectionInfo connectionInfo) {
            return MenuFlyoutItem(
              onPressed: () {},
              text: Text(connectionInfo.nameOfTheConnection),
            );
          }).toList());
        });
  }
}
