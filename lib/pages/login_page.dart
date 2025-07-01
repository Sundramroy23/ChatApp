import 'package:chatapp/services/auth/auth_services.dart';
import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final void Function()?
  ontap; //accept togglePage here for switching between login and register

  LoginPage({super.key, required this.ontap});

  void login(BuildContext context) async {
    final authservice = AuthServices();

    try{
      await authservice.signInWithEmailPassword(_emailcontroller.text, _pwdcontroller.text);
    }
    catch(e){
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }

  }

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pwdcontroller = TextEditingController();

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

            MyButton(ontap: () => login(context), message: "Submit"),

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
                GestureDetector(
                  onTap: ontap,
                  child: Text(
                    " Register Now",
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
