import 'package:quiz_app/core/models/api_models.dart';

/// Wrapper that allows the current user to be accessed from outside of
/// the main app without a [BuildContext].
class UserService {
  User _currentUser = User.anonymous();

  set currentUser(User newUser) => _currentUser = newUser;

  Progress get progress => _currentUser.progress;
  String? get email => _currentUser.email;
  String? get username => _currentUser.username;
  String? get profilePicture => _currentUser.profilePicturePath;
  bool get isAnonymous => _currentUser.uid.isEmpty;

  Map<String, bool> getProgressForQuiz(String quizId) {
    return _currentUser.progress.progress[quizId];
  }

  void setQuestionAnswered(String quizId, String questionId) {
    _currentUser.progress.progress[quizId][questionId] = true;
  }

  void updateUserInformation({
    required String key,
    required String value,
    required String uid,
  }) {}
}
