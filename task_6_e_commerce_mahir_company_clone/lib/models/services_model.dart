import 'package:cloud_firestore/cloud_firestore.dart';

class ServicesModel {
  final String serviceName;
  final String per;
  final String price;
  final String imageUrl;
  final bool available;

  ServicesModel(
      {required this.serviceName,
      required this.per,
      required this.price,
      required this.imageUrl,
      required this.available});

  ServicesModel copyWith(
      {String? serviceName,
      String? per,
      String? price,
      String? imageUrl,
      bool? available}) {
    return ServicesModel(
        serviceName: serviceName ?? this.serviceName,
        per: per ?? this.per,
        price: price ?? this.price,
        imageUrl: imageUrl ?? this.imageUrl,
        available: available ?? this.available);
  }

  factory ServicesModel.fromFirestore(DocumentSnapshot doc, String service) {
    Map data = doc.data() as Map<String, dynamic>;
    return ServicesModel(
        serviceName: data['serviceName']??'',
        per: data['per_$service']??'',
        price: data['price']??'',
        imageUrl: data['picture']??'',
        available: data['available']??true
    );
  }
}