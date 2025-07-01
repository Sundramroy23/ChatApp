import 'package:chatapp/auth/auth_services.dart';
import 'package:chatapp/components/my_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ChatApp")),
      drawer: MyDrawer(),
      body: Center(child: Text('Home Page')),
    );
  }
}
