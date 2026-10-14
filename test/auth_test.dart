import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_comeng_project/main.dart';
import 'package:flutter_comeng_project/models/demo_auth.dart';

void main() {
  test(
      'Reset requires valid OTP, changes credentials, and consumes verification',
      () {
    final auth = DemoAuth();
    expect(auth.changePassword('Updated@123'), isNotNull);
    expect(auth.startReset('demo@sau.ac.th'), isNull);
    expect(auth.verify('9999'), isNotNull);
    expect(auth.changePassword('Updated@123'), isNotNull);
    expect(auth.verify('1234'), isNull);
    expect(auth.changePassword('Updated@123'), isNull);
    expect(auth.signIn('demo@sau.ac.th', 'Demo@1234'), isNotNull);
    expect(auth.signIn('demo@sau.ac.th', 'Updated@123'), isNull);
    expect(auth.changePassword('Again@123'), isNotNull);
    auth.dispose();
  });
  test('Registration normalizes email and rejects duplicate accounts', () {
    final auth = DemoAuth();
    expect(auth.register(' User@example.com ', 'Example@123'), isNull);
    expect(auth.signIn('user@example.com', 'Example@123'), isNull);
    expect(auth.register('USER@example.com', 'Other@123'), isNotNull);
    expect(auth.startReset('missing@example.com'), isNotNull);
    auth.dispose();
  });
  testWidgets('Complete reset flow, mismatch validation, then login',
      (tester) async {
    await tester.pumpWidget(const ComengApp());
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Forgot Password?'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'demo@sau.ac.th');
    await tester.tap(find.text('Send Code'));
    await tester.pumpAndSettle();
    expect(find.text('OTP Verification'), findsOneWidget);
    for (var i = 0; i < 4; i++) {
      await tester.enterText(find.byKey(ValueKey('otp-$i')), '${i + 1}');
    }
    await tester.tap(find.text('Verify'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'Updated@123');
    await tester.enterText(find.byType(TextFormField).at(1), 'Mismatch@123');
    await tester.tap(find.text('Reset Password'));
    await tester.pumpAndSettle();
    expect(find.text('Passwords do not match.'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField).at(1), 'Updated@123');
    await tester.tap(find.text('Reset Password'));
    await tester.pumpAndSettle();
    expect(find.text('Password Changed!'), findsOneWidget);
    await tester.ensureVisible(find.text('Back to Login'));
    await tester.tap(find.text('Back to Login'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'demo@sau.ac.th');
    await tester.enterText(find.byType(TextFormField).at(1), 'Updated@123');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();
    expect(find.text('You are signed in to the local demo.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  testWidgets('Invalid email blocks reset navigation', (tester) async {
    await tester.pumpWidget(const ComengApp());
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Forgot Password?'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'invalid');
    await tester.tap(find.text('Send Code'));
    await tester.pumpAndSettle();
    expect(find.text('Enter a valid email address.'), findsOneWidget);
    expect(find.text('OTP Verification'), findsNothing);
  });
  testWidgets('Small-phone layout and registration have no overflow',
      (tester) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const ComengApp());
    await tester.ensureVisible(find.text('Login'));
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await tester.ensureVisible(find.text('Register Now'));
    await tester.tap(find.text('Register Now'));
    await tester.pumpAndSettle();
    expect(find.text('Create a demo account'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
