import 'package:flutter/material.dart';
import '../models/demo_auth.dart';
import '../widgets/auth_widgets.dart';
import 'register_dialog.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});
  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController(), _password = TextEditingController();
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _login() {
    if (!_form.currentState!.validate()) return;
    final error = AuthScope.of(context).signIn(_email.text, _password.text);
    if (error != null) {
      notice(context, error);
      return;
    }
    showDialog<void>(
        context: context,
        builder: (_) => AlertDialog(
                title: const Text('Welcome to SAU!'),
                content: const Text('You are signed in to the local demo.'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Done'))
                ]));
  }

  @override
  Widget build(BuildContext context) => AuthLayout(
      child: Form(
          key: _form,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const AuthHeading('Welcome to SAU! Glad\nto see you. Again!', ''),
            AuthField(
                label: 'Enter your email',
                controller: _email,
                validator: emailValidator),
            const SizedBox(height: 16),
            AuthField(
                label: 'Enter your password',
                controller: _password,
                password: true,
                validator: passwordValidator),
            Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/forgot'),
                    child: const Text('Forgot Password?',
                        style: TextStyle(
                            color: Color(0xFF69797C), fontSize: 12)))),
            const SizedBox(height: 5),
            PrimaryButton(label: 'Login', onPressed: _login),
            const SizedBox(height: 25),
            const Row(children: [
              Expanded(child: Divider()),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('Or Login with',
                      style:
                          TextStyle(color: Color(0xFF839093), fontSize: 12))),
              Expanded(child: Divider())
            ]),
            const SizedBox(height: 16),
            const SocialRow(),
            const SizedBox(height: 80),
            Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Text("Don't have an account?",
                      style: TextStyle(fontSize: 12)),
                  TextButton(
                      onPressed: () => showRegister(context),
                      child: const Text('Register Now',
                          style: TextStyle(color: mint, fontSize: 12)))
                ]),
          ])));
}
