
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final cartProvider = FutureProvider<List<CartModel>>((ref) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final phone = prefs.getString('user_phone');
  List<CartModel> carts = [];
  final DocumentSnapshot documentSnapshot =
      await FirebaseFirestore.instance.collection('cart').doc(phone).get();
  if (documentSnapshot.exists) {
    final data = documentSnapshot.data() as Map<String, dynamic>;
    carts = data.entries.map((entry) {
      final cartData = entry.value as Map<String, dynamic>;
      return CartModel(
          serviceName: cartData['serviceName'] ?? '',
          per: cartData['per'] ?? '',
          price: cartData['price'] ?? '',
          imageUrl: cartData['picture'] ?? '',
          rating: cartData['rating'] ?? '',
          available: cartData['available'] ?? '',
          quantity: cartData['quantity'] ?? 0,
          totalPrice: cartData['totalPrice'] ?? 0.0
      );
    }).toList();
    return carts;
  }
  return carts;
});
