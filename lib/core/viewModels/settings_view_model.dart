import 'package:quiz_app/core/services/services.dart';
import 'package:quiz_app/core/viewModels/base_model.dart';
import 'package:quiz_app/locator.dart';

class SettingsViewModel extends BaseModel {
  UserService _user = locator<UserService>();

  String get userImagePath => _user.profilePicture ?? '';
  String get userEmail => _user.email ?? '';
  String get username => _user.username ?? '';

  bool get isAnonymous => _user.isAnonymous;
}
