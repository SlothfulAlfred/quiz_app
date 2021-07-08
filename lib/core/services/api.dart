import 'package:quiz_app/core/models/api_models.dart';

/// Interface for interaction with Firebase services
abstract class Api {
  Future<LoginResponse> login(String email, String password);

  Future getQuizzes();

  Future getQuestions(int quizId);

  // TODO: consider rmoving this method instead pushing users onto a stream.
  Future getUserById(int uid);
}
