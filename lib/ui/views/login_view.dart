import 'package:flutter/material.dart';
import 'package:quiz_app/core/viewModels/login_view_model.dart';
import 'package:quiz_app/core/viewstate_enum.dart';
import 'package:quiz_app/ui/shared/base_view.dart';
import 'package:quiz_app/ui/shared/ui_helper.dart';
import 'package:quiz_app/ui/widgets/text_field.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // Is Stateful widget so that controllers can be disposed.
  final TextEditingController _passwordText = TextEditingController();
  final TextEditingController _emailText = TextEditingController();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();

  @override
  void dispose() {
    _passwordFocus.dispose();
    _passwordText.dispose();
    _emailFocus.dispose();
    _emailText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: BaseView<LoginViewModel, void, void>(
        builder: _buildContent,
        onBuild: (LoginViewModel model) {
          if (model.error != null) {
            _emailText.clear();
            _passwordText.clear();
          }
        },
      ),
    );
  }

  Widget _buildContent(
      BuildContext context, LoginViewModel model, Widget? child) {
    if (model.state == ViewState.idle) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: 34),
                    ),
                    HorizontalSpace.small,
                    FlutterLogo(
                      size: 50,
                    ),
                  ],
                ),
              ),
              VerticalSpace.medium,
              // Gives the cool elevated effect.
              Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Email Text Field.
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InputField(
                        controller: _emailText,
                        focus: _emailFocus,
                      ),
                    ),
                    // Divider to separate the two fields
                    Divider(
                      height: 2,
                      color: Colors.blueGrey,
                    ),
                    // password text field
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InputField(
                        controller: _passwordText,
                        focus: _passwordFocus,
                        isPassword: true,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(blurRadius: 0.5)],
                  color: Colors.grey[100],
                ),
              ),
              VerticalSpace.small,
              // This is the error text, will not render if there is no error.
              // The empty text is rendered so that if an error message appears,
              // it doesn't push down the login button.
              (model.error != null)
                  ? Text(
                      model.error!,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: Theme.of(context).errorColor),
                    )
                  : Text(
                      '',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
              VerticalSpace.small,
              // Wraps an [ElevatedButton] to provide a gradient effect.
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    colors: [
                      Colors.tealAccent,
                      Colors.pinkAccent,
                    ],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () =>
                      model.login(_emailText.text, _passwordText.text),
                  child: Text(
                    "Login",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent,
                    minimumSize: Size.fromHeight(50),
                  ),
                ),
              ),
              VerticalSpace.small,
              TextButton(
                child: Text(
                  'Forgot your password?',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Colors.blueGrey,
                      ),
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
