import 'package:flutter/material.dart';
import 'package:quiz_app/core/viewModels/settings_view_model.dart';
import 'package:quiz_app/core/viewstate_enum.dart';
import 'package:quiz_app/ui/shared/base_view.dart';
import 'package:quiz_app/ui/shared/ui_helper.dart';
import 'package:quiz_app/ui/widgets/gradient_button.dart';

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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 24.0,
                  ),
                  child: GradientButton(
                    onPressed: model.logout,
                    child: Text(
                      'Sign In',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
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
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.teal),
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
                    foregroundImage: (model.userImagePath != '')
                        ? FadeInImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(model.userImagePath),
                            placeholder:
                                AssetImage('assets/default_avatar.jpg'),
                          ) as ImageProvider
                        : AssetImage('assets/default_avatar.jpg'),
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
