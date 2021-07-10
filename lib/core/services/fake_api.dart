import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/core/services/api.dart';
import 'dart:math';

class FakeApi implements Api {
  @override
  Future getQuestions(int quizId) {
    // TODO: implement getQuestions
    throw UnimplementedError();
  }

  @override
  Future getQuizzes() {
    // TODO: implement getQuizzes
    throw UnimplementedError();
  }

  @override
  Future getUserById(int uid) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

  @override
  Future<LoginResponse> login(String username, String password) async {
    await Future.delayed(Duration(seconds: 1));
    // Randomly login successfully or throw an error
    int rand = Random().nextInt(5);
    switch (rand) {
      case 0:
        return LoginResponse(success: true);
      case 1:
        return LoginResponse(
          success: false,
          error: FirebaseAuthException(code: 'invalid-email'),
        );
      case 2:
        return LoginResponse(
          success: false,
          error: FirebaseAuthException(code: 'wrong-password'),
        );
      case 3:
        return LoginResponse(
          success: false,
          error: FirebaseAuthException(code: 'user-disabled'),
        );
      case 4:
        return LoginResponse(
          success: false,
          error: FirebaseAuthException(code: 'user-not-found'),
        );
      default:
        return LoginResponse(success: true);
    }
  }
}
