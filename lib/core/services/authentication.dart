import 'dart:async';

import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/core/services/api.dart';
import 'package:quiz_app/locator.dart';

class AuthenticationService {
  final Api _api = locator<Api>();

  StreamController<User> userStream = StreamController<User>();

  /// Pushes user onto a stream if logged in succesfully, or returns the appropriate
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
      // If user is logged in properly, push user info onto
      // a stream, and return true.
      userStream.add(
        User(
          email: response.user!.email!,
          uid: response.user!.uid,
          username: response.user!.displayName!,
        ),
      );
      return true;
    } else if (useFakeData) {
      // TODO: remove this unnecessary check.
      // Just for testing purposes since it's impossible to return
      // a [UserCredential] from [FakeApi].
      return true;
    } else {
      // Returns the error so that the ViewModel can handle it
      // if the user was not logged in successfully.
      return response.error;
    }
  }
}
