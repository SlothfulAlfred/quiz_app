import 'package:get_it/get_it.dart';
import 'package:quiz_app/core/services/api.dart';
import 'package:quiz_app/core/services/authentication.dart';
import 'package:quiz_app/core/services/fake_api.dart';
import 'package:quiz_app/core/services/firebase_api.dart';

GetIt locator = GetIt.instance();

bool useFakeData = true;

void setupLocator() {
  locator.registerLazySingleton<Api>(
      () => useFakeData ? FakeApi() : FirebaseApi());
  locator.registerLazySingleton<AuthenticationService>(
      () => AuthenticationService());
}
