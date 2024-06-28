import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_5_google_classroom_clone/screens/home_screen.dart';
import 'package:task_5_google_classroom_clone/screens/signin_screen.dart';


class VerifyEmail extends StatefulWidget {
  final String userId;
  const VerifyEmail({super.key, required this.userId});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  Timer? timer;
  bool canResendEmail=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if(!isEmailVerified){
      sendVerificationEmail();
    }
    timer=Timer.periodic(
      const Duration(seconds: 3),
        (_)=>checkEmailVerified(),
    );
  }

  @override
  void dispose(){
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async{
    //call after email verification!
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified=FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if(isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try{
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      
      setState(() {
        canResendEmail=false;
      });
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        canResendEmail=true; 
      });
    }
    catch(e){
      print('Error ${e.toString()}');
    }

  }
  @override
  Widget build(BuildContext context) =>
      isEmailVerified ? Home(userId: widget.userId) : Scaffold(
        appBar: AppBar(
          title: const Text('Verify Email'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'A verification email has been sent to your email.',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24,),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                icon: const Icon(Icons.email,size: 32,),
                label: const Text(
                  'Resent Email',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: canResendEmail ? sendVerificationEmail : null,
              ),
              const SizedBox(height: 24,),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  icon: const Icon(Icons.email,size: 32,),
                  label: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 24),
                  ),
                  onPressed: (){
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Do you want to Stop Verification'),
                          content: const SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text("Then sign in to complete verification"),
                              ],
                            ),
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  child: const Text('Abort'),
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                ),
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SignInScreen())); // Close the dialog
                                  },
                                ),
                              ],
                            )
                            
                          ],
                        );
                      },
                    );
                  },
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SignInScreen())),
              ),
            ],
          ),
        ),
      );
}
