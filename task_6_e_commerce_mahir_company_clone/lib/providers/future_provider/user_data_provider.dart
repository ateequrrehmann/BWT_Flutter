import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userFirebaseProvider=FutureProvider<UserData>((ref) async {
  SharedPreferences prefs=await SharedPreferences.getInstance();
  final phone = prefs.getString('user_phone');
  print(phone);
  UserData? userData;

  try{
    final documentSnapshot=await FirebaseFirestore.instance.collection('users').doc(phone).get();
    print(documentSnapshot.data());


    return UserData.fromFirestore(documentSnapshot);
  }catch(e){
    print(e);
  }

  return userData!;

});