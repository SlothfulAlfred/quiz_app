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
        builder: (BuildContext c, SettingsViewModel m, Widget? child) {
          if (m.state == ViewState.idle) {
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
                    foregroundImage: NetworkImage(m.userImagePath),
                    backgroundImage: AssetImage('assets/default_avatar.jpg'),
                  ),
                  VerticalSpace.medium,
                  if (m.isAnonymous)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'You are signed in as a guest. Your progress will not be saved!',
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  Text(
                    m.username,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  VerticalSpace.small,
                  Text(
                    m.userEmail,
                    style: Theme.of(context).textTheme.headline2,
                    overflow: TextOverflow.ellipsis,
                  ),
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
