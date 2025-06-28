import 'package:chatapp/auth/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  void onpressedLogout(BuildContext context) async {
    // final _userCredential = AuthServices();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Logging Out!", style: TextStyle(fontSize: 16)),
        backgroundColor: Theme.of(context).colorScheme.primary, // 70% opacity
        behavior: SnackBarBehavior.floating, // Optional: floating style
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(16), // Works with floating behavior
      ),
    );
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ChatApp"),
        actions: [
          IconButton(
            onPressed: () => onpressedLogout(context),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(child: Text('Home Page')),
    );
  }
}
