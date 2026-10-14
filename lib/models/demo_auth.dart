import 'package:flutter/material.dart';

/// Local, ephemeral account state. No credentials are sent or persisted.
class DemoAuth extends ChangeNotifier {
  final Map<String, String> _accounts = {'demo@sau.ac.th': 'Demo@1234'};
  String? resetEmail;
  DateTime? _expires;
  bool _verified = false;
  String? signIn(String email, String password) {
    return _accounts[email.trim().toLowerCase()] == password
        ? null
        : 'Email or password is incorrect.';
  }

  String? register(String email, String password) {
    final key = email.trim().toLowerCase();
    if (_accounts.containsKey(key)) return 'This email is already registered.';
    _accounts[key] = password;
    notifyListeners();
    return null;
  }

  String? startReset(String email) {
    final key = email.trim().toLowerCase();
    if (!_accounts.containsKey(key))
      return 'Use the demo account or register first.';
    resetEmail = key;
    _expires = DateTime.now().add(const Duration(minutes: 2));
    _verified = false;
    notifyListeners();
    return null;
  }

  String? verify(String code) {
    if (resetEmail == null ||
        _expires == null ||
        DateTime.now().isAfter(_expires!)) {
      return 'Code expired. Request a new code.';
    }
    if (code != '1234') return 'Incorrect verification code.';
    _verified = true;
    return null;
  }

  String? changePassword(String password) {
    if (!_verified ||
        resetEmail == null ||
        _expires == null ||
        DateTime.now().isAfter(_expires!)) {
      return 'Verify a current code before resetting your password.';
    }
    _accounts[resetEmail!] = password;
    resetEmail = null;
    _expires = null;
    _verified = false;
    notifyListeners();
    return null;
  }
}

class AuthScope extends InheritedNotifier<DemoAuth> {
  const AuthScope({super.key, required DemoAuth auth, required super.child})
      : super(notifier: auth);
  static DemoAuth of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AuthScope>()!.notifier!;
}
