import 'package:flutter/material.dart';
import 'package:my_app1/screens/Login_page.dart';
import 'package:my_app1/screens/register_page.dart';

class LogOrRegPage extends StatefulWidget {
  const LogOrRegPage({super.key});

  @override
  State<LogOrRegPage> createState() => _LogOrRegPageState();
}

class _LogOrRegPageState extends State<LogOrRegPage> {

  //initaially show login page
  bool showloginPage = true;

  // toggle between log and reg page
  void togglePages() {
    setState(() {
      showloginPage = !showloginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showloginPage) {
      return LoginPage(
        onTap: togglePages,
        );
    } else {
      return RegisterPage(onTap: togglePages);
    }
  }
}