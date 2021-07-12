import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/core/services/navigation_service.dart';
import 'package:quiz_app/core/services/quiz_service.dart';
import 'package:quiz_app/core/viewstate_enum.dart';
import 'package:quiz_app/locator.dart';
import 'package:quiz_app/core/viewModels/base_model.dart';
import 'package:quiz_app/ui/routing_constants.dart';

class HomeViewModel extends BaseModel {
  NavigationService _nav = locator<NavigationService>();
  QuizService _quizzes = locator<QuizService>();

  HomeViewModel() {
    getQuizzes();
  }

  List<Quiz> quiz = [];

  Future<void> getQuizzes() async {
    setState(ViewState.busy);
    quiz = await _quizzes.getQuizzes();
    setState(ViewState.idle);
  }

  void heroTapped(String id) {
    _nav.pushNamed(quizRoute, arguments: {'quizId': id});
  }
}
