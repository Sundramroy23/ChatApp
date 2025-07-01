import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/pages/signup_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool login = true;
  // we will pass toggle page to the pages to switch between them
  void togglePage() {
    setState(() {
      login = !login;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (login) {
      // pass togglePage as parameter from here thus pages can interact
      return LoginPage(ontap: togglePage);
    } else {
      return SignupPage(ontap: togglePage);
    }
  }
}
