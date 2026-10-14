import 'package:flutter/material.dart';
import '../models/demo_auth.dart';
import '../widgets/auth_widgets.dart';

class NewPasswordUI extends StatefulWidget {
  const NewPasswordUI({super.key});
  @override
  State<NewPasswordUI> createState() => _NewPasswordUIState();
}

class _NewPasswordUIState extends State<NewPasswordUI> {
  final _form = GlobalKey<FormState>();
  final _password = TextEditingController(), _confirm = TextEditingController();
  @override
  void dispose() {
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _reset() {
    if (!_form.currentState!.validate()) return;
    final error = AuthScope.of(context).changePassword(_password.text);
    if (error != null) {
      notice(context, error);
      return;
    }
    Navigator.pushNamedAndRemoveUntil(
        context, '/changed', (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) => AuthLayout(
      child: Form(
          key: _form,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const AuthHeading('Create new password',
                'Your new password must be different from the password you used before.'),
            AuthField(
                label: 'New password',
                controller: _password,
                password: true,
                validator: (value) {
                  final error = passwordValidator(value);
                  if (error != null) return error;
                  final auth = AuthScope.of(context);
                  if (auth.resetEmail != null &&
                      auth.signIn(auth.resetEmail!, value!) == null)
                    return 'Choose a different password.';
                  return null;
                }),
            const SizedBox(height: 16),
            AuthField(
                label: 'Confirm password',
                controller: _confirm,
                password: true,
                validator: (value) =>
                    value == _password.text ? null : 'Passwords do not match.'),
            const SizedBox(height: 24),
            PrimaryButton(label: 'Reset Password', onPressed: _reset),
          ])));
}
