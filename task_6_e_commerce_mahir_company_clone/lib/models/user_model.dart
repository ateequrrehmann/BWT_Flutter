import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';

class UserData {
  final String name;
  final String email;
  final String number;
  final String gender;
  final String? imageUrl;
  final String? bio;
  final LatLng location;

  const UserData({
    required this.name,
    required this.email,
    required this.number,
    required this.gender,
    required this.location,
    this.imageUrl,
    this.bio,
  });

  UserData copyWith({
    String? name,
    String? email,
    String? number,
    String? gender,
    String? imageUrl,
    String? bio,
    LatLng? location,
  }) {
    return UserData(
      name: name ?? this.name,
      email: email ?? this.email,
      number: number ?? this.number,
      gender: gender ?? this.gender,
      imageUrl: imageUrl ?? this.imageUrl,
      bio: bio ?? this.bio,
      location: location ?? this.location,
    );
  }

  factory UserData.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserData(
      name: data['userName'] ?? '',
      email: data['email'] ?? '',
      number: data['phone'] ?? '',
      gender: data['gender'] ?? '',
      bio: data['bio'] ?? '',
      imageUrl: data['imageUrl'],
      location: LatLng(
        (data['latlong'] as GeoPoint).latitude,
        (data['latlong'] as GeoPoint).longitude,
      ),
    );
  }


}
