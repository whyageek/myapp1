import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app1/models/my_textfield.dart';
import 'package:my_app1/models/sq_tile.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  Future<void> signUserIn() async {

    //show loading circle
      showDialog(
        context: context, 
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      );

    try {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailController.text,
    password: passwordController.text,
  );
} on FirebaseAuthException catch (e) {
  //Wrong EMAIL
  if (e.code == 'user-not-found') {
    //show error to user
    wrongEmailMessage();
  }

  //Wrong Password
  else if (e.code == 'user-not-found') {
    //show error to user
    wrongPasswordMessage();
  }
}

    //pop the loading circle
    Navigator.pop(context);
  }

  void wrongEmailMessage() {
    showDialog(context: 
    context, builder: (context) {
      return const AlertDialog(
        title: Text("Incorrect Email bbg"),
      );
    },);
  }

  void wrongPasswordMessage() {
    showDialog(context: 
    context, builder: (context) {
      return const AlertDialog(
        title: Text("Incorrect Password bb"),
      );
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 202, 202, 202),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 70,),
                
                const Icon(
                  Icons.lock,
                  size:100
                ),
        
                SizedBox(height: 50,),
        
                const Text("Wow Phirse Aagaye",
                  style: TextStyle(color: Colors.black, 
                  fontSize: 16,
                  ),
                ),
                //Text("Wow Phirse Aagaye"),
                //Text("Wow Phirse Aagaye"),
        
                const SizedBox(height: 40),
                
                //Username Textfield
                MyTextfield(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),
        
                const SizedBox(height: 15),
        
                //password Textfield
                MyTextfield(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
        
                const SizedBox(height: 15,),
        
                //forgot Password?
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Forgot Password?",
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))
                  ),
                    ],
                  ),
                  ),
        
                const SizedBox(height: 15,),
        
                //sign in Button
                GestureDetector(
                  onTap: signUserIn,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)
                      ),
                    child: const Center(child: Text(
                      "Sign in", 
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
        
                const SizedBox(height: 50,),
                
                //Divider
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black,
                       ), 
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text("Or continue with"),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black,
                       ), 
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 40,),
        
                //sign in buttons 
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google button
                    SqTile(imagePath: 'images/google.png'),
        
                    SizedBox(width: 40,),
        
                    //apple button
                    SqTile(imagePath: 'images/apple.png'),
                  ],
                ),
        
                const SizedBox(height:50,),
        
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    SizedBox(width: 10,),
                    Text('Register Now',
                    style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}