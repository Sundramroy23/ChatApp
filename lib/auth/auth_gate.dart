import 'package:chatapp/auth/login_or_register.dart';
import 'package:chatapp/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data!;
            if (!user.emailVerified) {
              Future.microtask(() {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: const Text("Verify your email"),
                        content: const Text(
                          'Please verify your email address to continue.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              await user.sendEmailVerification();
                              Navigator.of(context).pop();
                            },
                            child: const Text("Send Verification Email"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                );
              });
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Please verify your email to continue.'),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                      },
                      child: const Text("Back to Login"),
                    ),
                  ],
                ),
              );
            } else {
              return const HomePage();
            }
          } else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
