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

  void createAccount(
      String email, String username, String password, String confirmed) {
    if (password != confirmed) {
      setErrorMessage("Passwords don't match.");
    } else {
      setErrorMessage('');
    }
  }
}
