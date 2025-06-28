import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_textfield.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  void login() {}

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pwdcontroller = TextEditingController();

  SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // icon
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
              fill: 1,
            ),
            const SizedBox(height: 25),
            // welcome tect
            Text(
              "Welcome Back you have been missed!",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 25),
            // email
            MyTextfield(
              hintext: "Email",
              obscuretext: false,
              controller: _emailcontroller,
            ),
            // password
            const SizedBox(height: 25),
            MyTextfield(
              hintext: "Password",
              obscuretext: true,
              controller: _pwdcontroller,
            ),
            // sunmit
            const SizedBox(height: 25),

            MyButton(ontap: login),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a Member? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  " Register Now",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            // redirect
          ],
        ),
      ),
    );
  }
}
