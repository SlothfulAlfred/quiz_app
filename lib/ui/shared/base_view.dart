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
/// The types `P extends Object?, P2 extends Object?` allow for use of parameters to initialize
/// dependencies. This works well in conjunction with [GetIt.registerFactoryParam],
/// since there is no need for different building logic. To avoid this functionality,
/// use `BaseView<T, void, void>`. This is required since Dart does not have optional
/// type parameters for generics.
///
/// Taken (almost) directly from:
/// https://www.filledstacks.com/post/flutter-architecture-my-provider-implementation-guide/#shared-setup-for-all-views.
class BaseView<T extends BaseModel, P extends Object?, P2 extends Object?>
    extends StatefulWidget {
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

  /// Optional parameter that can be used to initialize dependencies
  /// that are dependant on parameters. For example, those registered
  /// using [GetIt.registerFactoryParam].
  final P? param;

  /// Only provide a value for this field if you have already provided
  /// a value for [param].
  final P2? paramTwo;

  const BaseView(
      {Key? key,
      required this.builder,
      this.onBuild,
      this.init,
      this.param,
      this.paramTwo})
      : super(key: key);

  @override
  _BaseViewState<T, P, P2> createState() => _BaseViewState<T, P, P2>();
}

class _BaseViewState<T extends BaseModel, P extends Object?, P2 extends Object?>
    extends State<BaseView<T, P, P2>> {
  late T model;

  @override
  void initState() {
    super.initState();
    if (widget.param != null) {
      model = locator.get<T>(param1: widget.param, param2: widget.paramTwo);
    } else {
      model = locator<T>();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (widget.param == null)
          ? (_) => locator<T>()
          : (_) =>
              locator.get<T>(param1: widget.param, param2: widget.paramTwo),
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
