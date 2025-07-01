  import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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