import 'package:quiz_app/core/services/authentication.dart';
import 'package:quiz_app/core/viewstate_enum.dart';
import 'package:quiz_app/locator.dart';
import 'package:quiz_app/ui/routing_constants.dart';
import 'package:quiz_app/core/services/navigation_service.dart';

import 'base_model.dart';

class RegistrationViewModel extends BaseModel {
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

  Future<void> createAccount({
    required String email,
    required String username,
    required String password,
    required String confirmed,
  }) async {
    if (password != confirmed) {
      setErrorMessage("Passwords don't match.");
    } else if (email.isEmpty ||
        username.isEmpty ||
        password.isEmpty ||
        confirmed.isEmpty) {
      setErrorMessage('One or more fields are empty.');
    } else {
      await _register(email, password, username);
    }
  }

  /// Attempts to register an account using an email and a password.
  Future<dynamic> _register(
    String email,
    String password,
    String username,
  ) async {
    setState(ViewState.busy);
    var result = await _auth.register(
      email: email,
      password: password,
      username: username,
    );
    if (result == true) {
      // pushReplacementNamed is used here so that the user cannot
      // press the back button and return to the login screen.
      _nav.pushReplacementNamed(homeRoute);
    } else {
      // Handling which error message to display
      switch (result.code) {
        case 'invalid-email':
          setErrorMessage('This email is invalid. Please try again.');
          break;
        case 'weak-password':
          setErrorMessage('This password is too weak. Please try again.');
          break;
        case 'operation-not-allowed':
          setErrorMessage(
              'Email registration is not allowed. Please contact us at xxx-xxx-xxxx for more information.');
          break;
        case 'email-already-in-use':
          setErrorMessage(
              'An account already exists for this email. Please try again.');
          break;
        default:
          setErrorMessage(
            "An error has occurred. Please check your internet connection and try again.",
          );
      }
    }
    // Now that we are done operations, state is no longer busy
    setState(ViewState.idle);
  }
}
