import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_app1/firebase_options.dart';
import 'package:my_app1/screens/home_page.dart';
import 'package:my_app1/screens/analysis_page.dart';
import 'package:my_app1/screens/auth_page.dart'; // Import your authentication page

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
        '/': (context) => AuthenticationWrapper(), // Use wrapper to handle authentication logic
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
    // Implement logic to check if user is authenticated
    const bool isUserAuthenticated = false; // Replace with your authentication logic

    if (isUserAuthenticated) {
      return const HomePage(); // Navigate to home page if user is authenticated
    } else { 
      return AuthPage(); // Navigate to authentication page if user is not authenticated
    }
  }
}
