import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/core/services/api.dart';
import 'package:quiz_app/locator.dart';

class AuthenticationService {
  final Api _api = locator<Api>();

  /// returns true if the user was logged in succesfully, or the appropriate
  /// [FirebaseAuthException] error.
  ///
  /// To maintain the single responsibility principle,
  /// [AuthenticationService] does not directly call
  /// [FirebaseAuth.signInWithEmailAndPassword] but instead defers that to [Api]
  /// so that [Api] is the only access point to Firebase.
  Future login({
    required String email,
    required String password,
  }) async {
    LoginResponse response = await _api.login(email, password);
    if (response.success == true) {
      // Returns true if the user has been logged in properly
      return true;
    } else {
      // Returns the error so that the ViewModel can handle it
      // if the user was not logged in successfully.
      return response.error;
    }
  }
}
