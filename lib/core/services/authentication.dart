import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/core/services/api.dart';
import 'package:quiz_app/core/services/services.dart';
import 'package:quiz_app/locator.dart';

class AuthenticationService {
  final Api _api = locator<Api>();
  final UserService _user = locator<UserService>();

  /// Sets current user if logged in succesfully, or returns the appropriate
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
    // Preventing [PlatformException] from appeating in [FirebaseApi].
    // It should be handled from within [FirebaseApi] since it is a
    // subtype of [Exception] and all [Exception]s are handled there,
    // but for some reason it still shows up.
    if (email.isEmpty || password.isEmpty) {
      return FirebaseAuthException(
          code: 'empty-field', message: 'One or more fields is empty.');
    }
    LoginResponse response = await _api.login(email, password);
    if (response.success == true) {
      // If user is logged in properly, get more user information that
      // isn't stored in firebase auth (pfp pathway, username, quiz progress),
      // then update the info in [UserService].
      var user = await _api.getUserById(response.uid!) as Map;
      _user.currentUser = User.fromJson(user);
      return true;
    } else {
      // Returns the error so that the ViewModel can handle it
      // if the user was not logged in successfully.
      return response.error;
    }
  }

  Future register({
    required String email,
    required String password,
    required String username,
  }) async {
    LoginResponse response = await _api.register(email, password);
    if (response.success == true) {
      // extract uid from newly created [UserCredentials].
      String uid = response.uid!;
      User newUser = User(
        email: email,
        username: username,
        profilePicturePath: null,
        uid: uid,
        progress: Progress.none(),
      );
      // Update current user in [UserService] and write user to firestore.
      _user.currentUser = newUser;
      await _api.writeDocument(document: newUser.toJson(), collection: 'users');
      return true;
    } else {
      return response.error;
    }
  }

  Future logout() async {
    await _api.logout();
    _user.currentUser = User.anonymous();
  }
}
