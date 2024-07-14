import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';

class UserNotifier extends StateNotifier<UserData>{
  UserNotifier(): super(const UserData(name: '', email: '', number: '', gender:'Male',));
  void updateName(String n){
    state=state.copyWith(name: n);
  }

  void updateEmail(String e){
    state=state.copyWith(email: e);
  }
  void updateNumber(String n){
    state=state.copyWith(number: n);
  }
  void updateGender(String g){
    state=state.copyWith(gender: g);
  }

  // void updateVerificationId(String v){
  //   state=state.copyWith(verificationId: v);
  // }

  void updateImageUrl(String url){
    state=state.copyWith(imageUrl: url);
  }
}