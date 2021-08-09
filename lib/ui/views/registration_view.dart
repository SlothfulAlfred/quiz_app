import 'package:flutter/material.dart';
import 'package:quiz_app/core/viewModels/registration_view_model.dart';
import 'package:quiz_app/ui/shared/base_view.dart';
import 'package:quiz_app/ui/shared/ui_helper.dart';
import 'package:quiz_app/ui/widgets/gradient_button.dart';
import 'package:quiz_app/ui/widgets/text_field.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  _RegistrationViewState createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  // [TextField] controllers and focuses.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailFocus.dispose();
    _usernameFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Create an account'),
      ),
      body: BaseView<RegistrationViewModel, void, void>(
        builder: (BuildContext context, RegistrationViewModel model, child) =>
            Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Create an account',
                style: Theme.of(context).textTheme.headline6!,
              ),
              VerticalSpace.medium,
              // Input Area.
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  boxShadow: [BoxShadow(blurRadius: 0.5)],
                ),
                // Input Fields.
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InputField(
                        controller: _emailController,
                        focus: _emailFocus,
                      ),
                      Divider(height: 2),
                      InputField(
                        controller: _usernameController,
                        focus: _usernameFocus,
                        hintText: 'Username...',
                      ),
                      Divider(height: 2),
                      InputField(
                        controller: _passwordController,
                        focus: _passwordFocus,
                        isPassword: true,
                      ),
                      Divider(height: 2),
                      InputField(
                        controller: _confirmPasswordController,
                        focus: _confirmPasswordFocus,
                        isPassword: true,
                        hintText: 'Confirm password...',
                      ),
                    ],
                  ),
                ),
              ),
              VerticalSpace.medium,
              // Fills up the space of the error message so it doesn't
              // shift the create account button when an error arises.
              (model.error != null)
                  ? Text(
                      model.error!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    )
                  : Text('', style: TextStyle(fontSize: 16)),
              VerticalSpace.small,
              // Create Account button.
              GradientButton(
                onPressed: () => model.createAccount(
                  email: _emailController.text,
                  username: _usernameController.text,
                  password: _passwordController.text,
                  confirmed: _confirmPasswordController.text,
                ),
                child: Text(
                  'Create Account',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
