import 'package:flutter/material.dart';
import 'package:quiz_app/core/viewstate_enum.dart';

/// Basic functionality of view models.
///
/// Encapsulates the state management aspect of the
/// view models so that the implmementation of the children
/// can be focused on case handling. See
/// https://www.filledstacks.com/post/flutter-architecture-my-provider-implementation-guide/
/// for more details.
class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.idle;

  ViewState get state => _state;

  void setState(ViewState state) {
    _state = state;
    notifyListeners();
  }
}
