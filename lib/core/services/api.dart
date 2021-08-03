import 'package:quiz_app/core/models/api_models.dart';

/// Interface for interaction with Firebase services
abstract class Api {
  Future<LoginResponse> login(String email, String password);

  Future getQuizzes();

  Future getQuestions(String quizId);

  // TODO: remove this method due to changes in data structure
  // This method might have been needed since the plan was to store
  // a short string as the imagePath for the quizzes, which would act
  // as an identifier to search Cloud Storage for the image, however
  // it is better to just store the entire Cloud Storage link in the
  // database.
  //
  // Benefits of this method are:
  // - Less calls to Cloud Storage
  // - Faster load time since images are retrieved directly
  //   (instead of getting the link then retrieving it)
  //
  // Detriments of this method are:
  // - Much harder to change the storage location in the future
  // - Slightly more data on the database (this isn't a realistic issue for
  //    an app of this scale, but it might be an issue if it was scaled up to
  //    contain millions or quizzes. It still should be considered though)
  Future? getPhotoFromPath(String url);

  Future getUserById(String uid);

  Future register(String email, String password);
}
