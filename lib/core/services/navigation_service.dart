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

  /// Same functionality as [NavigatorState.pushNamed]** but without
  /// the need for [BuildContext].
  ///
  /// ** [NavigatorState] is the return value of [Navigator.of].
  Future<Object?> pushNamed(String route, {dynamic arguments}) {
    // Using ! operator here because the navigator must exist since it
    // was created above.
    return nav.currentState!.pushNamed<dynamic>(route, arguments: arguments);
  }

  /// Same functionality as [NavigatorState.pop] but
  /// without the need for [BuildContext].
  void pop<T extends Object?>([T? result]) {
    return nav.currentState!.pop<dynamic>(result);
  }

  /// Same functionality as [NavigatorState.pushReplacementNamed] but
  /// without the need for [BuildContext].
  Future<Object?> pushReplacementNamed(String route, {dynamic arguments}) {
    // The <dynamic, dynamic> typing is to prevent a casting error.
    // "_CastError (type 'MaterialPageRoute<dynamic>' is not a subtype of type 'Route<Object>?' in type cast)"
    // It seems this happens because of issues with the return value, which explains why
    // having type inference would help. One possible solution offered on StackOverflow
    // is to explicitly type the MaterialPageRoutes in the onGenerateRoute function
    // which could help solve the casting error
    return nav.currentState!
        .pushReplacementNamed<dynamic, dynamic>(route, arguments: arguments);
  }

  /// Same functionality as [NavigatorState.popAndPushNamed] but without
  /// the need for [BuildContext].
  Future<Object?> popAndPushNamed(
    String route, {
    dynamic arguments,
    dynamic result,
  }) {
    return nav.currentState!.popAndPushNamed<dynamic, dynamic>(
      route,
      arguments: arguments,
      result: result,
    );
  }
}
