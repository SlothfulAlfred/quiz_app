import 'package:quiz_app/core/models/api_models.dart';

/// Interface for interaction with Firebase services
abstract class Api {
  /// Attempts to authenticate a user, returns a [LoginResponse] with
  /// the error in event of failure.
  Future<LoginResponse> login(String email, String password);

  /// Return a list of existing [Quiz] objects.
  Future getQuizzes();

  /// Return a list of [Question] objects associated with [quizId].
  Future getQuestions(String quizId);

  Future? getPhotoFromPath(String url);

  /// Return information about a user as a [Map].
  Future getUserById(String uid);

  /// Attempt to register a new user, returns the corresponding error
  /// in event of failure.
  Future<LoginResponse> register(
    String email,
    String password,
  );

  /// Updates a field of a user's information on Firestore.
  Future updateUserInfo({
    required String key,
    required String value,
    required String userId,
  });

  /// Writes a new document to Firestore.
  Future writeDocument({
    required Map<String, dynamic> document,
    required String collection,
  });
}
