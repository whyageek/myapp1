import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app1/screens/Log_or_reg_page.dart';
import 'package:my_app1/screens/Login_page.dart';
import 'package:my_app1/screens/home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user logged in
          if (snapshot.hasData) {
            return HomePage();
          }

          //user is NOT logged in
          else {
            return LogOrRegPage();
          }
        },
      ),
    );  
  }
}