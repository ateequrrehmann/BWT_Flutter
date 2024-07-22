import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryModel {
  final String serviceName;
  final String per;
  final String price;
  final String imageUrl;
  final String rating;
  final bool available;
  int quantity;
  final double totalPrice;
  final DateTime dateTime;

  HistoryModel(
      {required this.serviceName,
        required this.per,
        required this.price,
        required this.imageUrl,
        required this.rating,
        required this.available,
        required this.quantity,
        required this.totalPrice,
        required this.dateTime
      });

  HistoryModel copyWith(
      {String? serviceName,
        String? per,
        String? price,
        String? imageUrl,
        String? rating,
        bool? available,
        int? quantity,
        double? totalPrice, DateTime? dateTime}) {
    return HistoryModel(
      serviceName: serviceName ?? this.serviceName,
      per: per ?? this.per,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      available: available ?? this.available,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      dateTime: dateTime?? this.dateTime,
    );
  }

  factory HistoryModel.fromFirestore(DocumentSnapshot doc, String service) {
    Map data = doc.data() as Map<String, dynamic>;
    return HistoryModel(
        serviceName: data['serviceName'] ?? '',
        per: data['per_$service'] ?? '',
        price: data['price'] ?? '',
        imageUrl: data['picture'] ?? '',
        rating: data['rating'] ?? '',
        available: data['available'] ?? true,
        quantity: data['quantity'] ?? 0,
        totalPrice: data['totalPrice'] ?? 0.0,
      dateTime: (data['dateTime'] as Timestamp).toDate(),
    );
  }
}
