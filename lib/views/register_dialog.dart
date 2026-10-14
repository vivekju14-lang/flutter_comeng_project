import 'package:flutter/material.dart';
import '../models/demo_auth.dart';
import '../widgets/auth_widgets.dart';

Future<void> showRegister(BuildContext context) async {
  final auth = AuthScope.of(context);
  await showDialog<void>(
      context: context, builder: (_) => _RegisterDialog(auth: auth));
}

class _RegisterDialog extends StatefulWidget {
  const _RegisterDialog({required this.auth});
  final DemoAuth auth;
  @override
  State<_RegisterDialog> createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<_RegisterDialog> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController(), _password = TextEditingController();
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
          title: const Text('Create a demo account'),
          content: SizedBox(
              width: 340,
              child: SingleChildScrollView(
                  child: Form(
                      key: _form,
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        AuthField(
                            label: 'Email',
                            controller: _email,
                            validator: emailValidator),
                        const SizedBox(height: 14),
                        AuthField(
                            label: 'Password',
                            controller: _password,
                            password: true,
                            validator: passwordValidator),
                      ])))),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  if (!_form.currentState!.validate()) return;
                  final error =
                      widget.auth.register(_email.text, _password.text);
                  if (error != null) {
                    notice(context, error);
                    return;
                  }
                  Navigator.pop(context);
                },
                child: const Text('Register'))
          ]);
}
