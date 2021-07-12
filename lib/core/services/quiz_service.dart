import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/locator.dart';

import 'api.dart';

class QuizService {
  final Api _api = locator<Api>();

  Future<List<Quiz>> getQuizzes() async {
    return await _api.getQuizzes();
  }

  Future<List<Question>> getQuestionsForQuiz(String id) async {
    return await _api.getQuestions(id);
  }
}
