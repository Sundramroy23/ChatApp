import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final String hintext;
  final bool obscuretext;
  final TextEditingController controller;
  const MyTextfield({
    super.key,
    required this.hintext,
    required this.obscuretext,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        obscureText: obscuretext,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide(width: 10)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText: hintext,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
