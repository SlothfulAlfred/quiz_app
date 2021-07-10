import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/core/services/api.dart';
import 'package:quiz_app/core/viewstate_enum.dart';
import 'package:quiz_app/locator.dart';
import 'package:quiz_app/core/viewModels/base_model.dart';

class HomeViewModel extends BaseModel {
  Api _api = locator<Api>();

  HomeViewModel() {
    fetchImage();
  }

  List<Quiz> quiz = [];

  Future fetchImage() async {
    setState(ViewState.busy);
    var _imagePath = await _api.getPhotoFromPath('url');
    quiz.add(Quiz(
      description: '',
      id: 0,
      title: '',
      imagePath: _imagePath,
      length: 10,
    ));
    setState(ViewState.idle);
  }
}
