import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class TermzillaConnectionsController extends ControllerMVC {
  factory TermzillaConnectionsController([StateMVC? state]) =>
      _this ??= TermzillaConnectionsController._(state);

  TermzillaConnectionsController._(StateMVC? state) : super(state);

  static TermzillaConnectionsController? _this;

  final formKey = GlobalKey<FormState>();
}
