import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/views/screens/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import '../../../main.dart';
import '../registeration_login/register_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var isLogin = false;
  var auth = FirebaseAuth.instance;
  String? phone;

  Future<void> checkIfLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    phone = prefs.getString('user_phone');

    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        setState(() {
          isLogin = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkIfLogin().then((_) {
      Timer(Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => isLogin && phone != null
                ? ProfilePage()
                : RegisterScreen(),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              child: Image.asset('lib/assets/mahir.jpg'),
            ),

          ],
        ),
      ),
    );
  }
}
