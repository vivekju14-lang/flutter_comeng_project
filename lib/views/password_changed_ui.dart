import 'package:flutter/material.dart';
import '../widgets/auth_widgets.dart';

class PasswordChangedUI extends StatelessWidget {
  const PasswordChangedUI({super.key});
  @override
  Widget build(BuildContext context) => AuthLayout(
      back: false,
      child: Column(children: [
        const SizedBox(height: 155),
        const Icon(Icons.verified, size: 104, color: mint),
        const SizedBox(height: 30),
        const Text('Password Changed!',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
        const SizedBox(height: 13),
        const Text('Your password has been changed\nsuccessfully.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF7F8B8D), height: 1.5)),
        const SizedBox(height: 38),
        SizedBox(
            width: double.infinity,
            child: PrimaryButton(
                label: 'Back to Login',
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => route.isFirst))),
      ]));
}
