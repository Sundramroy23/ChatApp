import 'package:chatapp/auth/auth_gate.dart';
import 'package:chatapp/auth/login_or_register.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/pages/signup_page.dart';
import 'package:chatapp/theme/light_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: AuthGate(),
    );
  }
}

class VerificationEmailSender extends StatelessWidget {
  final User user;

  const VerificationEmailSender({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        try {
          await user.sendEmailVerification();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Verification email sent!')));
        } catch (e) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: $e')));
        }
        Navigator.of(context).pop();
      },
      child: const Text("Send Verification Email"),
    );
  }
}
