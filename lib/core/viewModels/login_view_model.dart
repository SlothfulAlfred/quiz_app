import 'package:quiz_app/core/services/authentication.dart';
import 'package:quiz_app/core/viewstate_enum.dart';
import 'package:quiz_app/locator.dart';
import 'package:quiz_app/ui/routing_constants.dart';
import 'package:quiz_app/core/services/navigation_service.dart';

import 'base_model.dart';

class LoginViewModel extends BaseModel {
  AuthenticationService _auth = locator<AuthenticationService>();
  NavigationService _nav = locator<NavigationService>();

  /// The error message that should be displayed, if it exists.
  /// i.e. 'email or password is incorrect'
  String? _errorMessage;

  void setErrorMessage(String s) {
    _errorMessage = s;
    notifyListeners();
  }

  String? get error => _errorMessage;

  Future<dynamic> login(String email, String password) async {
    setState(ViewState.busy);
    var result = await _auth.login(email: email, password: password);
    if (result == true) {
      // pushReplacementNamed is used here so that the user cannot
      // press the back button and return to the login screen.
      _nav.pushReplacementNamed(homeRoute);
    } else {
      // Handling which error message to display
      switch (result.code) {
        case 'invalid-email':
          setErrorMessage('Email or password is incorrect. Please try again.');
          break;
        case 'wrong-password':
          setErrorMessage('Email or password is incorrect. Please try again.');
          break;
        case 'user-not-found':
          setErrorMessage('User cannot be found. Please try again.');
          break;
        case 'user-disabled':
          setErrorMessage('Your account has been disabled.');
          break;
        default:
          setErrorMessage(result.message);
      }
    }
    // Now that we are done operations, state is no longer busy
    setState(ViewState.idle);
  }
}
