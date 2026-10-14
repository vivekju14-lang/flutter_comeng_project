import 'package:flutter/material.dart';
import '../widgets/auth_widgets.dart';
import '../widgets/developer_art.dart';
import 'register_dialog.dart';

class WelcomeUI extends StatelessWidget {
  const WelcomeUI({super.key});
  @override
  Widget build(BuildContext context) => AuthLayout(
      back: false,
      child: Column(children: [
        const SizedBox(height: 45),
        const DeveloperArt(),
        const SizedBox(height: 30),
        const Icon(Icons.settings_outlined, color: mint, size: 57),
        const SizedBox(height: 8),
        const Text('SAUDeveloper',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700)),
        const SizedBox(height: 40),
        SizedBox(
            width: double.infinity,
            child: PrimaryButton(
                label: 'Login',
                onPressed: () => Navigator.pushNamed(context, '/login'))),
        const SizedBox(height: 12),
        SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    foregroundColor: ink,
                    side: const BorderSide(color: ink),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6))),
                onPressed: () => showRegister(context),
                child: const Text('Register'))),
        const SizedBox(height: 36),
        const Text('Created by SAU Developer\nSouth East Asia University',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: mint, height: 1.5)),
      ]));
}
