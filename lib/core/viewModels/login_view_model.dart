import 'package:quiz_app/core/services/authentication.dart';
import 'package:quiz_app/core/viewstate_enum.dart';
import 'package:quiz_app/locator.dart';
import 'package:quiz_app/ui/routing_constants.dart';

import 'base_model.dart';

class LoginViewModel extends BaseModel {
  AuthenticationService _auth = locator<AuthenticationService>();

  /// The error message that should be displayed, if it exists.
  /// i.e. 'email or password is incorrect'
  String? _errorMessage;

  void setErrorMessage(String s) {
    _errorMessage = s;
  }

  String? get error => _errorMessage;

  Future login(String email, String password) async {
    setState(ViewState.busy);
    var result = await _auth.login(email: email, password: password);
    if (result is bool) {
      // TODO: Implement Navigation without context
      // https://www.filledstacks.com/post/navigate-without-build-context-in-flutter-using-a-navigation-service/
      throw UnimplementedError();
    }
  }
}
