import 'package:flutter/material.dart';
import 'package:quiz_app/core/viewModels/login_view_model.dart';
import 'package:quiz_app/core/viewstate_enum.dart';
import 'package:quiz_app/ui/shared/base_view.dart';
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
      appBar: AppBar(),
      body: BaseView<LoginViewModel>(
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
              // email text field
              InputField(
                controller: _emailText,
                focus: _emailFocus,
              ),
              // password text field
              InputField(
                controller: _passwordText,
                focus: _passwordFocus,
                isPassword: true,
                error: model.error,
              ),
              ElevatedButton(
                onPressed: () =>
                    model.login(_emailText.text, _passwordText.text),
                child: Text("Login"),
              ),
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
