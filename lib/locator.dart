import 'package:get_it/get_it.dart';
import 'package:quiz_app/core/services/services.dart';
import 'package:quiz_app/core/viewModels/view_models.dart';

import 'core/models/api_models.dart' show Quiz;

GetIt locator = GetIt.instance;

// Toogle the use of the fake Api
bool useFakeData = false;

// All ViewModels should be registered as factory so that they can be
// re-accessed. For example, if you register [LoginViewModel] as a
// singleton, once you pop the route the object will be garbage collected.
// If you try to navigate to the login page after [LoginViewModel] has been
// destroyed, it will throw an error. On the other hand, services can be
// registered as singletons since they are never garbage collected
// (since they are never called directly by a View).
void setupLocator() {
  // Services
  locator.registerLazySingleton<Api>(
      () => useFakeData ? FakeApi() : FirebaseApi());
  locator.registerLazySingleton<AuthenticationService>(
      () => AuthenticationService());
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<QuizService>(() => QuizService());
  locator.registerLazySingleton<ScaffoldService>(() => ScaffoldService());
  locator.registerLazySingleton<UserService>(() => UserService());

  // ViewModels
  locator.registerFactory<LoginViewModel>(() => LoginViewModel());
  locator.registerFactory<HomeViewModel>(() => HomeViewModel());
  locator.registerFactory<QuizViewModel>(() => QuizViewModel());
  locator.registerFactory<RegistrationViewModel>(() => RegistrationViewModel());
  locator.registerFactory<SettingsViewModel>(() => SettingsViewModel());
  locator.registerFactoryParam<QuestionsViewModel, Quiz, void>(
      (quiz, _) => QuestionsViewModel(quiz: quiz!));
}
