import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_5_google_classroom_clone/screens/signin_screen.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MaterialApp(
      home: SignInScreen(),
      debugShowCheckedModeBanner: false,
    )
  );
}
