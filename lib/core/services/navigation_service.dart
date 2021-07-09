import 'package:flutter/material.dart';

/// A class that wraps a [NavigatorState] so that navigation does not require
/// [BuildContext].
///
/// The [NavigatorState] is kept by using a [GlobalKey] so that it can be
/// identified without [BuildContext]. This allows for navigation inside
/// of ViewModels which helps to keep business logic outside of Views.
/// For this service to work, you need to set [MaterialApp.navigatorKey] to
/// [nav].
///
/// Using a [NavigatorState] works because [Navigator.of] returns a reference
/// to a [NavigatorState], so all 'normal' navigation is done through
/// a [NavigatorState].
///
/// For more info visit:
///
/// https://www.filledstacks.com/post/navigate-without-build-context-in-flutter-using-a-navigation-service/
/// https://api.flutter.dev/flutter/widgets/GlobalKey-class.html
/// https://api.flutter.dev/flutter/material/MaterialApp/navigatorKey.html
class NavigationService {
  final GlobalKey<NavigatorState> nav = GlobalKey<NavigatorState>();

  Future<Object?> pushNamed(String route, {dynamic arguments}) {
    // Using ! operator here because the navigator must exist since it
    // was created above.
    return nav.currentState!.pushNamed(route, arguments: arguments);
  }

  // Matching the signature of [Navigator.pop].
  void pop<T extends Object?>([T? result]) {
    return nav.currentState!.pop(result);
  }
}
