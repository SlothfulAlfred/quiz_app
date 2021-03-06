import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/core/services/api.dart';
import 'dart:math';

/// Provides fake data for testing purposes.
class FakeApi implements Api {
  @override
  Future getQuestions(String quizId) async {
    await Future.delayed(Duration(seconds: 1));
    return [
      Question(
        id: '0',
        quizId: '0',
        question: 'a sample question?',
        choices: {
          '0': Choice(
              isCorrect: false,
              hintText: 'Better luck next time',
              text: 'first choice'),
          '1': Choice(
              isCorrect: false,
              hintText: 'Third time\'s the charm...',
              text: 'second choice'),
          '2': Choice(
            isCorrect: true,
            hintText: null,
            text: 'corect choice',
          ),
          '3': Choice(
            isCorrect: false,
            hintText: 'The good thing about rock bottom...',
            text: 'another wrong choice',
          ),
        },
      ),
      Question(
        id: '1',
        quizId: '0',
        question: 'another sample question?',
        choices: {
          '0': Choice(
            isCorrect: false,
            hintText: 'Better luck next time',
            text: 'second first choice',
          ),
          '1': Choice(
            isCorrect: false,
            hintText: 'Third time\'s the charm...',
            text: 'second second choice',
          ),
          '2': Choice(
            isCorrect: true,
            hintText: null,
            text: 'second corect choice',
          ),
          '3': Choice(
            isCorrect: false,
            hintText: 'The good thing about rock bottom...',
            text: 'second another wrong choice',
          ),
        },
      ),
    ];
  }

  @override
  Future getQuizzes() async {
    await Future.delayed(Duration(seconds: 1));
    List<Quiz> quizzes = [];
    quizzes.add(Quiz(
      id: '0',
      title: 'fake Quiz 0',
      imagePath:
          'https://firebasestorage.googleapis.com/v0/b/quiz-app-53115.appspot.com/o/flutter_logo.png?alt=media&token=e1342fc0-9d96-46e6-98e4-5b12ed0525a0',
      description: 'a fake quiz for testing.',
      length: 2,
    ));
    quizzes.add(Quiz(
      id: '1',
      title: 'fake Quiz 1',
      imagePath:
          'https://firebasestorage.googleapis.com/v0/b/quiz-app-53115.appspot.com/o/flutter_logo.png?alt=media&token=e1342fc0-9d96-46e6-98e4-5b12ed0525a0',
      description: 'a fake quiz for testing.',
      length: 2,
    ));
    return quizzes;
  }

  @override
  Future getUserById(String uid) async {
    await Future.delayed(Duration(seconds: 1));
    return {
      'uid': uid,
      'progress': Progress.none(),
      'profilePicture': '',
      'displayName': 'Tester McTest',
      'email': 'testing@testing.com',
    };
  }

  @override
  Future<LoginResponse> login(String username, String password) async {
    await Future.delayed(Duration(seconds: 1));
    // Randomly login successfully or throw an error
    int rand = Random().nextInt(5);
    switch (rand) {
      case 0:
        return LoginResponse(
          success: true,
          uid: '0',
        );
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

  @override
  Future? getPhotoFromPath(String url) async {
    await Future.delayed(Duration(seconds: 1));
    return "https://firebasestorage.googleapis.com/v0/b/quiz-app-53115.appspot.com/o/flutter_logo.png?alt=media&token=e1342fc0-9d96-46e6-98e4-5b12ed0525a0";
  }

  @override
  Future<LoginResponse> register(String email, String password) async {
    return LoginResponse(success: true, uid: '0');
  }

  @override
  Future updateUserInfo({
    required String key,
    required dynamic value,
    required String userId,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  @override
  Future writeDocument({
    required Map<String, dynamic> document,
    required String collection,
    String? docId,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  @override
  Future logout() async {
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  @override
  Future anonymousLogin() async {
    await Future.delayed(Duration(seconds: 1));
    return;
  }
}
