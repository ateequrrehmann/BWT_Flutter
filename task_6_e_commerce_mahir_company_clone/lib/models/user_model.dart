import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String name;
  final String email;
  final String number;
  final String gender;
  // final String verificationId;
  final String? imageUrl;
  final String? bio;

  const UserData(
      {required this.name,
      required this.email,
      required this.number,
      required this.gender,
      // required this.verificationId,
      this.imageUrl,
      this.bio});

  UserData copyWith({
    String? name,
    String? email,
    String? number,
    String? gender,
    // String? verificationId,
    String? imageUrl,
    String? bio
  }) {
    return UserData(
      name: name ?? this.name,
      email: email ?? this.email,
      number: number ?? this.number,
      gender: gender ?? this.gender,
      // verificationId: verificationId ?? this.verificationId,
      imageUrl: imageUrl ?? this.imageUrl,
      bio: bio?? this.bio
    );
  }

  factory UserData.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    print('hellowwwwwwww'+data['userName']);
    return UserData(
        name: data['userName']??'',
        email: data['email']??'',
        number: data['phone']??'',
        gender: data['gender']??'',
      bio: data['bio']??'',
    );
  }
}
