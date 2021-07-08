import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/core/services/api.dart';

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
    // Always returns a succesful login (for now).
    if (1 == 1) {
      return LoginResponse(success: true);
    } else {
      return LoginResponse(
          success: false, error: FirebaseAuthException(code: 'invalid-email'));
    }
  }
}
