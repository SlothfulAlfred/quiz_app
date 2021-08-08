import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/core/services/api.dart';
import 'package:quiz_app/locator.dart';

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

  /// Returns a list of completed question ID's for the current user.
  List<String> getProgressForQuiz(String quizId) {
    var progress = _currentUser.progress.progress;
    if (progress.containsKey(quizId)) {
      return progress[quizId]!;
    }
    return <String>[];
  }

  void setQuestionAnswered(String quizId, String questionId) {
    var progress = _currentUser.progress.progress;
    if (progress.containsKey(quizId)) {
      progress[quizId]!.add(questionId);
    } else {
      progress[quizId] = [questionId];
    }
  }

  /// Updates the key-value pair of a user with the given uid.
  void updateUserInformation({
    required String key,
    required String value,
    required String uid,
  }) {
    _api.updateUserInfo(key: key, value: value, userId: uid);
  }

  // Private interface
  final Api _api = locator<Api>();
}
