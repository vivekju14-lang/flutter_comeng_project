# flutter_comeng_project

Assignment 03 — Flutter/Dart, Rajesh Kumar Upadhayay — 6819110001.

Six-screen SAUDeveloper UI recreated from the supplied reference:
1. Welcome and Login/Register entry
2. Login, password visibility and local registration dialog
3. Forgot password email form
4. Four-digit OTP verification and resend
5. New password and confirmation
6. Password changed confirmation and return to login

## Run
Install a stable Flutter SDK, then run `flutter pub get` and `flutter run -d chrome` (or an Android/iOS device). Android, iOS, web and Windows project scaffolds are included. Tested platforms and checks are recorded below after verification. Desktop views center a phone-width white surface; mobile layouts scroll for keyboard and smaller screens.

## Try the full flow
Use `demo@sau.ac.th` and `Demo@1234` to log in. Select Forgot Password, enter the demo email, use OTP `1234`, choose a different password of at least eight characters, confirm it, and return to Login. The old password is rejected and the new password works within that app session. Registration creates another temporary demo account.

All authentication state is in memory and resets when the app restarts. No email/SMS, OAuth or real server authentication is connected. The social sign-in buttons explain this when selected. OTP expires after two minutes; resend starts a new interval. This is a coursework UI demo, not a production identity service. Do not enter real credentials.

The welcome illustration is original Flutter CustomPainter vector artwork; fonts are bundled with their license. No external image or font requests are required. The supplied small screenshot is the visual reference; the artwork is an approximation because original illustration assets were not provided.

## Source organization
`lib/views/` contains each screen; `lib/widgets/` provides fields, buttons, layout and illustration; `lib/models/` holds demo account/reset state. Widget and state tests cover navigation, validation and password reset. Submit the GitHub repository link for this assignment.

## Verification
- flutter analyze: no issues found.
- flutter test: all five tests passed, including full reset flow and small-phone layout.
- flutter build web --no-web-resources-cdn: succeeded.
Native Android, iOS and Windows scaffolds are included; native builds were not tested.

## Assignment submission
https://github.com/vivekju14-lang/flutter_comeng_project
