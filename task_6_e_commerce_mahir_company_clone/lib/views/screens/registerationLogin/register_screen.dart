import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:myapp/views/screens/registerationLogin/user_details_screen.dart';
import '../../../providers/stateNotifier/userProvider.dart';
import '../../reusable_widgets/reusableSnackBar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPhoneValid = false;
  String completePhoneNumber = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EBEB),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(30, 77, 30, 86),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Welcome to Mahir Company',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Register by entering your phone number',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    IntlPhoneField(
                      controller: _phoneController,
                      initialCountryCode: 'PK',
                      onChanged: (phone) {
                        setState(() {
                          completePhoneNumber = phone.completeNumber;
                          _isPhoneValid = completePhoneNumber.isNotEmpty;
                        });
                      },
                      onCountryChanged: (country) {
                        print("+${country.dialCode}");
                      },
                      decoration: InputDecoration(
                          labelText: "XXXXXXXXXX",
                          labelStyle: TextStyle(
                            color: Colors.black.withOpacity(0.9),
                          ),
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          fillColor: const Color(0xFFFFFFFF),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none))),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Consumer(builder: (context, ref, child){
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate() &&
                                _isPhoneValid) {
                              ref.read(userProvider.notifier).updateNumber(completePhoneNumber);
                              print(completePhoneNumber);
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>const UserDetailScreen()));
                            } else {
                              if (!_isPhoneValid) {
                                reusableSnackBar(
                                    context, 'Phone number can\'t be empty');
                              }
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)))),
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      );

                    }),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     const Text(
                    //       "Already have account?",
                    //       style: TextStyle(color: Colors.black),
                    //     ),
                    //     MouseRegion(
                    //       cursor: SystemMouseCursors.click,
                    //       child: GestureDetector(
                    //         onTap: () {
                    //           Navigator.push(
                    //               context,
                    //               MaterialPageRoute(
                    //                   builder: (context) =>
                    //                   const SignInScreen()));
                    //         },
                    //         child: const Text(
                    //           " Login",
                    //           style: TextStyle(color: Color(0xFFEC407A)),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
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
