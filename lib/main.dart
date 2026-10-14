import 'package:flutter/material.dart';
import 'models/demo_auth.dart';
import 'views/welcome_ui.dart';
import 'views/login_ui.dart';
import 'views/forgot_password_ui.dart';
import 'views/otp_verification_ui.dart';
import 'views/new_password_ui.dart';
import 'views/password_changed_ui.dart';

void main() => runApp(const ComengApp());

class ComengApp extends StatefulWidget {
  const ComengApp({super.key});
  @override
  State<ComengApp> createState() => _ComengAppState();
}

class _ComengAppState extends State<ComengApp> {
  final auth = DemoAuth();
  @override
  void dispose() {
    auth.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AuthScope(
      auth: auth,
      child: MaterialApp(
        title: 'SAUDeveloper',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'ComengFont',
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xFF36BFA6)),
            textTheme: ThemeData.light().textTheme.apply(
                fontFamily: 'ComengFont', bodyColor: const Color(0xFF20262B))),
        home: const WelcomeUI(),
        routes: {
          '/login': (_) => const LoginUI(),
          '/forgot': (_) => const ForgotPasswordUI(),
          '/otp': (_) => const OtpVerificationUI(),
          '/new-password': (_) => const NewPasswordUI(),
          '/changed': (_) => const PasswordChangedUI(),
        },
      ));
}
