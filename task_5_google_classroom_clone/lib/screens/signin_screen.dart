import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_5_google_classroom_clone/screens/home_screen.dart';
import 'package:task_5_google_classroom_clone/screens/reset_password.dart';
import 'package:task_5_google_classroom_clone/screens/signup_screen.dart';
import 'package:task_5_google_classroom_clone/screens/verify_email.dart';

import '../reusable_widgets/reusable_widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(colors: [
        //       hexStringToColor("CB2B93"),
        //       hexStringToColor("9546C4"),
        //       hexStringToColor("5E61F4")
        //     ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery
                .of(context)
                .size
                .height * 0.2, 20, 0),
            child: Column(
              children: [
                Image.asset(
                  'lib/assets/GoogleClassroom.jpg',
                  fit: BoxFit.fitWidth,
                  width: 180,
                  height: 180,
                  // color: Colors.white,
                ),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter Email", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _passwordTextController,
                  obscureText: !_isPasswordVisible,
                  // Update based on visibility
                  enableSuggestions: false,
                  autocorrect: false,
                  cursorColor: Colors.black,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.9),
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Colors.black,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isPasswordVisible =
                          !_isPasswordVisible; // Toggle visibility
                        });
                      },
                      child: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons
                            .visibility_off, // Change icon based on visibility
                        color: Colors.black,
                      ),
                    ),
                    labelText: "Enter Password",
                    labelStyle: TextStyle(
                      color: Colors.black.withOpacity(0.9),
                    ),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.black.withOpacity(0.3),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(
                  height: 5,
                ),
                forgetPassword(context),
                firebaseButton(context, "Sign In", () async {
                  String? userId;
                  // Check if email is verified before signing in
                  if (FirebaseAuth.instance.currentUser!.emailVerified) {
                    try{
                      UserCredential userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text);
                      userId=userCredential.user!.uid;
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home(userId: userCredential.user!.uid)));
                    }catch(error){
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Wrong Credentials'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text("Error ${error.toString()}"),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  } else {
                    // Navigate to verification screen if email is not verified
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>VerifyEmail(userId: userId!)));
                  }
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have account?",
                      style: TextStyle(color: Colors.black),
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()));
                        },
                        child: const Text(
                          " Sign Up",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forget Password?",
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.right,
        ),
        onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>const ResetPassword())),
      ),

    );
  }
}
