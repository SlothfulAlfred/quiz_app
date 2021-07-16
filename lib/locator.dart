import 'package:get_it/get_it.dart';
import 'package:quiz_app/core/services/services.dart';
import 'package:quiz_app/core/viewModels/view_models.dart';

GetIt locator = GetIt.instance;

// Toogle the use of the fake Api
bool useFakeData = true;

void setupLocator() {
  // Services
  locator.registerLazySingleton<Api>(
      () => useFakeData ? FakeApi() : FirebaseApi());
  locator.registerLazySingleton<AuthenticationService>(
      () => AuthenticationService());
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<QuizService>(() => QuizService());
  locator.registerLazySingleton<SnackBarService>(() => SnackBarService());

  // ViewModels
  locator.registerLazySingleton<LoginViewModel>(() => LoginViewModel());
  locator.registerFactory<HomeViewModel>(() => HomeViewModel());
  locator.registerFactory<QuizViewModel>(() => QuizViewModel());
  // Passes through a parameter to QuestionsViewModel so that it can
  // initialize properly.
  locator.registerFactoryParam<QuestionsViewModel, String, void>(
      (String? id, _) => QuestionsViewModel(id: id!));
}
