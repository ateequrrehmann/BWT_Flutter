
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/cart_model.dart';
import 'package:myapp/models/history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final historyProvider = FutureProvider<List<HistoryModel>>((ref) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final phone = prefs.getString('user_phone');
  List<HistoryModel> carts = [];
  final DocumentSnapshot documentSnapshot =
  await FirebaseFirestore.instance.collection('history').doc(phone).get();
  if (documentSnapshot.exists) {
    final data = documentSnapshot.data() as Map<String, dynamic>;
    final items = data['items'] as Map<String, dynamic>;
    final dateTime = (data['dateTime'] as Timestamp).toDate();
    carts = items.entries.map((entry) {
      final cartData = entry.value as Map<String, dynamic>;
      print(cartData);
      return HistoryModel(
          serviceName: cartData['serviceName'] ?? '',
          per: cartData['per'] ?? '',
          price: cartData['price'] ?? '',
          imageUrl: cartData['picture'] ?? '',
          rating: cartData['rating'] ?? '',
          available: cartData['available'] ?? '',
          quantity: cartData['quantity'] ?? 0,
          totalPrice: cartData['totalPrice'] ?? 0.0,
        dateTime: dateTime,
      );
    }).toList();
    return carts;
  }
  return carts;
});
