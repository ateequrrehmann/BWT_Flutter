import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../providers/state_notifier_provider/userProvider.dart';
import '../../reusable_widgets/resuableTextField.dart';
import '../../reusable_widgets/reusableSnackBar.dart';
import 'opt_screen.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({super.key});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String gender = 'Male';
  final _formKey = GlobalKey<FormState>();
  var _valueRadio = 1;
  bool isLoading = false;
  String imageUrl="https://firebasestorage.googleapis.com/v0/b/mahircompanyclone.appspot.com/o/default_image%2Favatar.png?alt=media&token=1c65efe5-cb3c-4a6e-9fff-3e0ed9e5b661";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EBEB),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(30, 77, 30, 86),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    reusableTextFormField(
                        "Name", Icons.person, _nameController, true),
                    const SizedBox(
                      height: 50,
                    ),
                    reusableTextFormField(
                        "Email", Icons.email, _emailController, false),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Text(
                            "Select gender",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                        SizedBox(
                          width: 198.0,
                          child: Column(
                            children: [
                              RadioListTile<int>(
                                title: const Text("Male"),
                                value: 1,
                                groupValue: _valueRadio,
                                onChanged: (value) {
                                  setState(() {
                                    _valueRadio = value!;
                                    gender = "Male";
                                  });
                                },
                                contentPadding: EdgeInsets.zero,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ),
                              RadioListTile(
                                title: const Text("Female"),
                                value: 2,
                                groupValue: _valueRadio,
                                onChanged: (value) {
                                  setState(() {
                                    _valueRadio = value!;
                                    gender = "Female";
                                  });
                                },
                                contentPadding: EdgeInsets.zero,
                              ),
                              RadioListTile(
                                title: const Text("Other"),
                                value: 3,
                                groupValue: _valueRadio,
                                onChanged: (value) {
                                  setState(() {
                                    _valueRadio = value!;
                                    gender = "Other";
                                  });
                                },
                                contentPadding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Consumer(builder: (context, ref, child) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              ref
                                  .watch(userProvider.notifier)
                                  .updateName(_nameController.text);
                              ref
                                  .watch(userProvider.notifier)
                                  .updateEmail(_emailController.text);
                              ref
                                  .watch(userProvider.notifier)
                                  .updateGender(gender);
                              ref
                                  .watch(userProvider.notifier)
                                  .updateImageUrl(imageUrl);
                              final username = ref.watch(
                                  userProvider.select((value) => value.name));
                              final completePhoneNumber = ref.watch(
                                  userProvider.select((value) => value.number));
                              print('check$username');
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                await FirebaseAuth.instance.verifyPhoneNumber(
                                    phoneNumber: completePhoneNumber,
                                    verificationCompleted:
                                        (PhoneAuthCredential credential) {},
                                    verificationFailed:
                                        (FirebaseAuthException e) {
                                      reusableSnackBar(context,
                                          '${e.message!} Verification failed');
                                    },
                                    codeSent: (String verificationId,
                                        int? resendToken) async {
                                      SharedPreferences prefs=await SharedPreferences.getInstance();
                                      prefs.setString('verification_id', verificationId);
                                      print('user detail screen $verificationId');
                                      // ref
                                      //     .watch(userProvider.notifier)
                                      //     .updateVerificationId(verificationId);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                   OtpForm()));
                                    },
                                    codeAutoRetrievalTimeout:
                                        (String verificationId) {
                                      // _dismissLoadingDialog(context);
                                    });
                              } catch (e) {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            } else {}
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OtpForm(phone: _phoneController.text)));
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
