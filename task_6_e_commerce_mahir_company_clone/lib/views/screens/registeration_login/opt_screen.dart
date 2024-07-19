import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../providers/state_notifier_provider/userProvider.dart';
import '../../reusable_widgets/reusableSnackBar.dart';
import '../main_screens/home_screen.dart';
import '../profile_screen/profile_screen.dart';
class OtpForm extends StatefulWidget {
  const OtpForm({super.key});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var code;
  bool isLoading = false; // Track the loading state
  final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(fontSize: 22, color: Colors.white),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.transparent),
      ));

  final focusedPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(fontSize: 22, color: Colors.white),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.transparent),
      ));

  final submittedPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(fontSize: 22, color: Colors.white),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.transparent),
      ));



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EBEB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
        child: Container(
          margin: const EdgeInsets.only(top: 40),
          width: double.infinity,
          child: Consumer(builder: (context, ref, child){
            final phone=ref.watch(userProvider.select((value) => value.number));
            // final id=ref.watch(userProvider.select((value) => value.verificationId));
            final name=ref.watch(userProvider.select((value) => value.name));
            final email=ref.watch(userProvider.select((value) => value.email));
            final gender=ref.watch(userProvider.select((value) => value.gender));
            print('after fetching gender value');

            const image='https://firebasestorage.googleapis.com/v0/b/mahircompanyclone.appspot.com/o/default_image%2Favatar.png?alt=media&token=1c65efe5-cb3c-4a6e-9fff-3e0ed9e5b661';
            return Column(
              children: [
                const Text(
                  'OTP Verification',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 40),
                  child: const Text(
                    'Enter the code sent to your number',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  child: Text(
                    phone,
                    style: const TextStyle(color: Color(0xFF7985F0), fontSize: 20),
                  ),
                ),
                Pinput(
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  onCompleted: (pin) {
                    print(gender);
                    code = pin;
                    isLoading?null
                    :verifyUser(name, phone, email, image, gender);
                  },
                ),
                // Container(
                //   margin: EdgeInsets.only(top: 40),
                //   child: Text(
                //     'I Didn\'t Receive a Code!',
                //     style: TextStyle(color: Colors.black, fontSize: 20),
                //   ),
                // ),
                // TextButton(
                //   onPressed: () {},
                //   child: Text(
                //     'Resend Code',
                //     style: TextStyle(color: Color(0xFF7985F0), fontSize: 20),
                //   ),
                // ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : ()=>verifyUser(name, phone, email, image, gender),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)))),
                    child: isLoading
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : const Text(
                      'Verify',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              ],
            );
          }),

        ),
      ),
    );
  }

  Future<void> verifyUser(String name, String phone, String email, String image, String gender)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    String? verification_id=prefs.getString('verification_id');
    print(verification_id);
    print('User Gender is $gender');
    setState(() {
      isLoading = true;
    });
    try {

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verification_id!, smsCode: code);
      UserCredential usercredential=await auth.signInWithCredential(credential);
      // Save user details to Firestore ---> additionally I have to add latlong when the user creates the account
      DocumentSnapshot documentSnapshot =
      await FirebaseFirestore.instance
          .collection('users')
          .doc(phone)
          .get();
      if(documentSnapshot.exists==false){
        await FirebaseFirestore.instance
            .collection('users')
            .doc(phone)
            .set({
          'userName': name,
          'phone': phone,
          'email': email,
          'user_id': usercredential.user?.uid,
          'imageUrl': 'lib/assets/avatar.png',
          'gender': gender,
          'bio': 'Empty Bio',
          'latlong': LatLng(0.0, 0.0),
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_phone', phone);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const ProfilePage()));
      }
      else{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_phone', phone);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Home()));
      }

    } catch (e) {
      setState(() {
        isLoading = false;
      });
      reusableSnackBar(context, "Invalid OTP");
      print("wrong otp");
    }
  }
}
