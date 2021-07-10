import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/core/viewModels/base_model.dart';
import 'package:quiz_app/locator.dart';

/// Class that handles the data binding of the View to the ViewModel.
///
/// The View is bound to the ViewModel using a [ChangeNotifierProvider].
/// The ViewModel is injected using the get_it locator from [locator.dart].
/// The [builder] paramter is passed into the [Consumer.builder] so that it
/// rebuilds whenever the state of the ViewModel changes.
///
/// My own additon, [onBuild] is a closure that should run whenever the View
/// reubilds. For example, if there is a LoginViewModel that includes additional
/// functionality of setting an error message (the same way as state is set in the [BaseModel]),
/// you may want to clear a [TextField] in LoginView whenever the error changes. This
/// would be a good place to use [onBuild] instead of crowding the [builder] function.
///
/// Taken (almost) directly from:
/// https://www.filledstacks.com/post/flutter-architecture-my-provider-implementation-guide/#shared-setup-for-all-views.
class BaseView<T extends BaseModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final void Function(T)? onBuild;

  /// This feature was shown to work in FilledStack's provider guide
  /// but it no longer works. To get the same functionality, put
  /// this function inside of the constructor of the ViewModel
  /// and register it as a LazySingleton so that it runs when
  /// it is needed. More info at:
  /// https://stackoverflow.com/questions/57559489/flutter-provider-in-initstate.
  @deprecated
  final Function(T)? init;

  const BaseView({Key? key, required this.builder, this.onBuild, this.init})
      : super(key: key);

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> {
  T model = locator<T>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (_) => locator<T>(),
      child: Consumer<T>(
        builder: (BuildContext context, T model, Widget? child) {
          if (widget.onBuild != null) {
            widget.onBuild!(model);
          }
          return widget.builder(context, model, child);
        },
      ),
    );
  }
}
