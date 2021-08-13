import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/core/services/navigation_service.dart';
import 'package:quiz_app/core/services/user_service.dart';
import 'package:quiz_app/core/viewModels/base_model.dart';
import 'package:quiz_app/locator.dart';
import 'package:quiz_app/ui/routing_constants.dart';

class QuizViewModel extends BaseModel {
  void onHeroTapped() {
    //_nav.pop();
  }

  void onStartPressed(Quiz quiz) {
    _nav.pushNamed(
      questionsRoutePrefix,
      arguments: {
        'quiz': quiz,
      },
      // Saves user progress after exiting [QuestionsView].
    ).then((_) async => await _user.updateUserInformation(
          key: 'progress',
          value: _user.progress.progress,
          uid: _user.uid,
        ));
  }

  // Private Interface

  NavigationService _nav = locator<NavigationService>();
  UserService _user = locator<UserService>();
}
