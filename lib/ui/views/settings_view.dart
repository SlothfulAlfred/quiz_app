import 'package:flutter/material.dart';
import 'package:quiz_app/core/viewModels/settings_view_model.dart';
import 'package:quiz_app/core/viewstate_enum.dart';
import 'package:quiz_app/ui/shared/base_view.dart';
import 'package:quiz_app/ui/shared/ui_helper.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          textAlign: TextAlign.center,
        ),
      ),
      body: BaseView<SettingsViewModel, void, void>(
        builder: (BuildContext c, SettingsViewModel model, Widget? child) {
          if (model.state == ViewState.idle) {
            // To be displayed under the circular avatar.
            List<Widget> content;
            if (model.isAnonymous) {
              content = [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'You are signed in as a guest. Your progress will not be saved!',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                ),
                VerticalSpace.medium,
                TextButton(
                  child: Text(
                    'Sign In',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  onPressed: model.logout,
                )
              ];
            } else {
              content = [
                Text(
                  model.username,
                  style: Theme.of(context).textTheme.headline4,
                ),
                VerticalSpace.small,
                Text(
                  model.userEmail,
                  style: Theme.of(context).textTheme.headline2,
                  overflow: TextOverflow.ellipsis,
                ),
                VerticalSpace.medium,
                TextButton(
                  child: Text(
                    'Sign Out',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  onPressed: model.logout,
                )
              ];
            }
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 100,
                    // [CircleAvatar] tries to load in [foregroundImage] first,
                    // then falls back to [backgroundImage]. If [userImagePath]
                    // returns an empty string, the loading will fail and a default
                    // image will be loaded.
                    // TODO: Wrap in [FadeInImage].
                    foregroundImage: NetworkImage(model.userImagePath),
                    backgroundImage: AssetImage('assets/default_avatar.jpg'),
                  ),
                  VerticalSpace.medium,
                  ...content,
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
