/// Interface for interaction with Firebase services
abstract class Api {
  Future login(String username, String password);

  Future getQuizzes();

  Future getQuestions(int quizId);

  Future getUserById(int uid);
}
