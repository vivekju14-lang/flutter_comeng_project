import 'package:flutter/material.dart';
import '../models/demo_auth.dart';
import '../widgets/auth_widgets.dart';

class ForgotPasswordUI extends StatefulWidget {
  const ForgotPasswordUI({super.key});
  @override
  State<ForgotPasswordUI> createState() => _ForgotPasswordUIState();
}

class _ForgotPasswordUIState extends State<ForgotPasswordUI> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  void _send() {
    if (!_form.currentState!.validate()) return;
    final error = AuthScope.of(context).startReset(_email.text);
    if (error != null) {
      notice(context, error);
      return;
    }
    Navigator.pushNamed(context, '/otp');
  }

  @override
  Widget build(BuildContext context) => AuthLayout(
      child: Form(
          key: _form,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const AuthHeading('Forgot Password?',
                "Don't worry! It happens. Please enter the email address linked with your account."),
            AuthField(
                label: 'Enter your email',
                controller: _email,
                validator: emailValidator),
            const SizedBox(height: 22),
            PrimaryButton(label: 'Send Code', onPressed: _send),
            const SizedBox(height: 180),
            const LoginFooter(),
          ])));
}
