import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:task_5_google_classroom_clone/screens/signin_screen.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsBinding widgetsBinding=WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(Duration(seconds: 2));
  FlutterNativeSplash.remove();
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
