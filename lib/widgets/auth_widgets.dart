import 'package:flutter/material.dart';

const ink = Color(0xFF20262B);
const mint = Color(0xFF36BFA6);
String? emailValidator(String? value) =>
    RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value?.trim() ?? '')
        ? null
        : 'Enter a valid email address.';
String? passwordValidator(String? value) =>
    (value?.length ?? 0) >= 8 ? null : 'Use at least 8 characters.';
void notice(BuildContext context, String message) =>
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key, required this.child, this.back = true});
  final Widget child;
  final bool back;
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFF2F4F5),
        body: Center(
            child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: ColoredBox(
              color: Colors.white,
              child: SafeArea(
                  child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 26, vertical: 22),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: (constraints.maxHeight - 44)
                            .clamp(0, double.infinity)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (back)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                    tooltip: 'Back',
                                    onPressed: () =>
                                        Navigator.maybePop(context),
                                    icon: const Icon(Icons.arrow_back_ios_new,
                                        size: 19))),
                          if (back) const SizedBox(height: 22),
                          child,
                        ]),
                  ),
                ),
              ))),
        )),
      );
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key, required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) => SizedBox(
      height: 52,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: ink,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              elevation: 0),
          child: Text(label)));
}

class AuthField extends StatefulWidget {
  const AuthField(
      {super.key,
      required this.label,
      required this.controller,
      this.password = false,
      this.validator});
  final String label;
  final TextEditingController controller;
  final bool password;
  final String? Function(String?)? validator;
  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool _hidden = true;
  @override
  Widget build(BuildContext context) => TextFormField(
        controller: widget.controller,
        obscureText: widget.password && _hidden,
        keyboardType: widget.password
            ? TextInputType.visiblePassword
            : TextInputType.emailAddress,
        autocorrect: false,
        enableSuggestions: !widget.password,
        validator: widget.validator,
        decoration: InputDecoration(
            hintText: widget.label,
            labelText: widget.label,
            filled: true,
            fillColor: const Color(0xFFF6F8F8),
            suffixIcon: widget.password
                ? IconButton(
                    tooltip: _hidden ? 'Show password' : 'Hide password',
                    onPressed: () => setState(() => _hidden = !_hidden),
                    icon: Icon(
                        _hidden
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 19))
                : null,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFFDCE3E4))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Color(0xFFDCE3E4))),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 18)),
      );
}

class AuthHeading extends StatelessWidget {
  const AuthHeading(this.title, this.subtitle, {super.key});
  final String title, subtitle;
  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            style: const TextStyle(
                fontSize: 27,
                height: 1.2,
                fontWeight: FontWeight.w700,
                color: ink)),
        if (subtitle.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(subtitle,
              style: const TextStyle(
                  color: Color(0xFF7F8B8D), height: 1.5, fontSize: 14))
        ],
        const SizedBox(height: 30),
      ]);
}

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Text('Remember password? ', style: TextStyle(fontSize: 13)),
            TextButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (r) => r.isFirst),
                child: const Text('Login', style: TextStyle(color: mint))),
          ]));
}

class SocialRow extends StatelessWidget {
  const SocialRow({super.key});
  @override
  Widget build(BuildContext context) => Row(children: [
        for (final provider in ['Facebook', 'Google', 'Apple'])
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFDCE3E4)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          minimumSize: const Size(0, 48)),
                      onPressed: () => notice(context,
                          '$provider sign-in is not connected in this UI demo.'),
                      child: Semantics(
                          label: '$provider sign in',
                          child: provider == 'Apple'
                              ? const Icon(Icons.apple, color: ink, size: 25)
                              : Text(provider == 'Google' ? 'G' : 'f',
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w700,
                                      color: provider == 'Google'
                                          ? const Color(0xFF4285F4)
                                          : const Color(0xFF1877F2))))))),
      ]);
}
