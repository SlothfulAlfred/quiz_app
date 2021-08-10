import 'package:quiz_app/core/services/authentication.dart';
import 'package:quiz_app/core/services/user_service.dart';
import 'package:quiz_app/core/services/navigation_service.dart';
import 'package:quiz_app/core/viewModels/base_model.dart';
import 'package:quiz_app/core/viewstate_enum.dart';
import 'package:quiz_app/locator.dart';
import 'package:quiz_app/ui/routing_constants.dart';

class SettingsViewModel extends BaseModel {
  String get userImagePath => _user.profilePicture ?? '';
  String get userEmail => _user.email ?? '';
  String get username => _user.username ?? '';

  bool get isAnonymous => _user.isAnonymous;

  Future<void> logout() async {
    setState(ViewState.busy);
    await _auth.logout();
    _nav.pushReplacementNamed(loginRoute);
    setState(ViewState.idle);
  }

  // Private interface
  UserService _user = locator<UserService>();
  NavigationService _nav = locator<NavigationService>();
  AuthenticationService _auth = locator<AuthenticationService>();
}
