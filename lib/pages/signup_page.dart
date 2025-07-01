import 'package:chatapp/auth/auth_services.dart';
import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  void ontapSignup(BuildContext context) {
    final _auth = AuthServices();
    if (_pwdcontroller.text == _pwdtwocontroller.text &&
        _pwdcontroller.text.isNotEmpty) {
      try {
        _auth.singUpWithEmail(_emailcontroller.text, _pwdcontroller.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text(e.toString())),
        );
      }
    }
  }

  final VoidCallback ontap; //we will accept togglePage parameter as ontap here

  SignupPage({super.key, required this.ontap});

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pwdcontroller = TextEditingController();
  final TextEditingController _pwdtwocontroller = TextEditingController();

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
              "Let's create an account for you",
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
            MyTextfield(
              hintext: "Confirm Password",
              obscuretext: true,
              controller: _pwdtwocontroller,
            ),
            // sunmit
            const SizedBox(height: 25),

            MyButton(ontap: () => ontapSignup(context), message: "Register"),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account ? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: ontap,
                  child: Text(
                    " Log In",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
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
