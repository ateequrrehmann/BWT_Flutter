import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String serviceName;
  final String per;
  final String price;
  final String imageUrl;
  final String rating;
  final bool available;
  int quantity;
  final double totalPrice;

  CartModel(
      {required this.serviceName,
      required this.per,
      required this.price,
      required this.imageUrl,
      required this.rating,
      required this.available,
      required this.quantity,
      required this.totalPrice});

  CartModel copyWith(
      {String? serviceName,
      String? per,
      String? price,
      String? imageUrl,
      String? rating,
      bool? available,
      int? quantity,
      double? totalPrice}) {
    return CartModel(
      serviceName: serviceName ?? this.serviceName,
      per: per ?? this.per,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      available: available ?? this.available,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  factory CartModel.fromFirestore(DocumentSnapshot doc, String service) {
    Map data = doc.data() as Map<String, dynamic>;
    return CartModel(
        serviceName: data['serviceName'] ?? '',
        per: data['per_$service'] ?? '',
        price: data['price'] ?? '',
        imageUrl: data['picture'] ?? '',
        rating: data['rating'] ?? '',
        available: data['available'] ?? true,
        quantity: data['quantity'] ?? 0,
        totalPrice: data['totalPrice'] ?? 0.0);
  }
}
