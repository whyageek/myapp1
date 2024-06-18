import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_app1/firebase_options.dart';
import 'package:my_app1/screens/auth_page.dart';
import 'package:my_app1/screens/home_page.dart';
import 'package:my_app1/screens/analysis_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Set initial route
      routes: {
        '/': (context) => const AuthenticationWrapper(), // Use wrapper to handle authentication logic
        '/home': (context) => const HomePage(), // Define home route
        '/analysis': (context) => AnalysisPage(dailyCigaretteCount: 10, monthlyCigaretteCount: 1100), // Define analysis page route
        // Add more routes as needed
      },
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key});

  @override
  Widget build(BuildContext context) {
    const bool isUserAuthenticated = true; 

    if (isUserAuthenticated) {
      return const AuthPage();
    }
  }
}