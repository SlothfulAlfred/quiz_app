import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/core/services/navigation_service.dart';
import 'package:quiz_app/core/viewModels/base_model.dart';
import 'package:quiz_app/locator.dart';
import 'package:quiz_app/ui/routing_constants.dart';

class QuizViewModel extends BaseModel {
  NavigationService _nav = locator<NavigationService>();

  void onHeroTapped() {
    _nav.pop();
  }

  void onStartPressed(Quiz quiz) {
    _nav.pushNamed(questionRoute, arguments: quiz);
  }
}
