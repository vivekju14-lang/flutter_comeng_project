import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/demo_auth.dart';
import '../widgets/auth_widgets.dart';

class OtpVerificationUI extends StatefulWidget {
  const OtpVerificationUI({super.key});
  @override
  State<OtpVerificationUI> createState() => _OtpVerificationUIState();
}

class _OtpVerificationUIState extends State<OtpVerificationUI> {
  final _digits = List.generate(4, (_) => TextEditingController());
  final _focus = List.generate(4, (_) => FocusNode());
  @override
  void dispose() {
    for (final c in _digits) {
      c.dispose();
    }
    for (final f in _focus) {
      f.dispose();
    }
    super.dispose();
  }

  void _verify() {
    final code = _digits.map((c) => c.text).join();
    if (code.length != 4) {
      notice(context, 'Enter all four digits.');
      return;
    }
    final error = AuthScope.of(context).verify(code);
    if (error != null) {
      notice(context, error);
      return;
    }
    Navigator.pushNamed(context, '/new-password');
  }

  @override
  Widget build(BuildContext context) => AuthLayout(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const AuthHeading('OTP Verification',
            'Enter the verification code to continue your password reset.'),
        Row(children: [
          for (var i = 0; i < 4; i++)
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(right: i == 3 ? 0 : 12),
              child: TextField(
                  key: ValueKey('otp-$i'),
                  controller: _digits[i],
                  focusNode: _focus[i],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                  onChanged: (v) {
                    if (v.isNotEmpty && i < 3) {
                      _focus[i + 1].requestFocus();
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Digit ${i + 1}',
                      counterText: '',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)))),
            ))
        ]),
        const SizedBox(height: 24),
        PrimaryButton(label: 'Verify', onPressed: _verify),
        const SizedBox(height: 26),
        const Text('Demo verification code: 1234',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF7F8B8D), fontSize: 12)),
        Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Text("Didn't receive the code?",
                  style: TextStyle(fontSize: 12)),
              TextButton(
                  onPressed: () {
                    final auth = AuthScope.of(context);
                    final email = auth.resetEmail;
                    if (email == null) {
                      notice(context, 'Start a password reset first.');
                      return;
                    }
                    auth.startReset(email);
                    for (final c in _digits) {
                      c.clear();
                    }
                    _focus[0].requestFocus();
                    notice(context, 'Demo code renewed: 1234');
                  },
                  child: const Text('Resend', style: TextStyle(color: mint))),
            ]),
      ]));
}
