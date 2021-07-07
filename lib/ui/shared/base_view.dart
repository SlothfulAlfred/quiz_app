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
/// Taken directly from https://www.filledstacks.com/post/flutter-architecture-my-provider-implementation-guide/#shared-setup-for-all-views.
class BaseView<T extends BaseModel> extends StatelessWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;

  const BaseView({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (_) => locator<T>(),
      child: Consumer<T>(
        builder: builder,
      ),
    );
  }
}
