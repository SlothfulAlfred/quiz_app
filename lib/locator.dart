import 'package:get_it/get_it.dart';
import 'package:quiz_app/core/services/services.dart';
import 'package:quiz_app/core/viewModels/view_models.dart';

GetIt locator = GetIt.instance;

// Toogle the use of the fake Api
bool useFakeData = true;

void setupLocator() {
  locator.registerLazySingleton<Api>(
      () => useFakeData ? FakeApi() : FirebaseApi());
  locator.registerLazySingleton<AuthenticationService>(
      () => AuthenticationService());
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<LoginViewModel>(() => LoginViewModel());
  locator.registerFactory<HomeViewModel>(() => HomeViewModel());
  locator.registerLazySingleton<QuizService>(() => QuizService());
}
