import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/core/services/navigation_service.dart';
import 'package:quiz_app/core/services/quiz_service.dart';
import 'package:quiz_app/core/services/user_service.dart';
import 'package:quiz_app/core/viewstate_enum.dart';
import 'package:quiz_app/locator.dart';
import 'package:quiz_app/core/viewModels/base_model.dart';
import 'package:quiz_app/ui/routing_constants.dart';

class HomeViewModel extends BaseModel {
  NavigationService _nav = locator<NavigationService>();
  QuizService _quizzes = locator<QuizService>();
  UserService _user = locator<UserService>();

  HomeViewModel() {
    getQuizzes();
  }

  List<Quiz> quiz = [];

  Future<void> getQuizzes() async {
    setState(ViewState.busy);
    quiz = await _quizzes.getQuizzes();
    setState(ViewState.idle);
  }

  void heroTapped(Quiz quiz) {
    // Pushes the quiz route and then signals for [HomeView] to
    // rebuild so that the progress bar will be updated.
    _nav
        .pushNamed(quizRoute, arguments: quiz)
        .then((value) => notifyListeners());
  }

  int getCompletedForQuiz(String id) {
    int completed = 0;
    var quizProgress = _user.getProgressForQuiz(id);
    for (bool isAnswered in quizProgress.values) {
      if (isAnswered) completed++;
    }
    return completed;
  }
}
