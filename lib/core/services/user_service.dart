import 'package:quiz_app/core/models/api_models.dart';

/// Wrapper that allows the current user to be accessed from outside of
/// the main app without a [BuildContext].
class UserService {
  User _currentUser = User.anonymous();

  set currentUser(User newUser) => _currentUser = newUser;

  get progress => _currentUser.progress;

  Map<String, bool> getProgressForQuiz(String quizId) {
    return _currentUser.progress.progress[quizId];
  }

  void setQuestionAnswered(String quizId, String questionId) {
    _currentUser.progress.progress[quizId][questionId] = true;
  }
}
