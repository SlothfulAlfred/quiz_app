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
  String get uid => _currentUser.uid;
  bool get isAnonymous => _currentUser.uid.isEmpty;

  /// Returns a list of completed question ID's for the current user.
  List<String> getProgressForQuiz(String quizId) {
    var progress = _currentUser.progress.progress;

    return List<String>.from((progress[quizId] ?? <String>[]));
  }

  void setQuestionAnswered(String quizId, String questionId) {
    var progress = _currentUser.progress.progress;
    if (progress.containsKey(quizId)) {
      progress[quizId]!.add(questionId);
    } else {
      progress[quizId] = [questionId];
    }
  }

  /// Updates a key-value pair of a user on Cloud Firestore using the uid.
  ///
  /// Doesn't update if the current user is anonymously signed in.
  Future<void> updateUserInformation({
    required String key,
    required dynamic value,
    required String uid,
  }) async {
    if (!isAnonymous)
      await _api.updateUserInfo(key: key, value: value, userId: uid);
  }

  // Private interface
  final Api _api = locator<Api>();
}
