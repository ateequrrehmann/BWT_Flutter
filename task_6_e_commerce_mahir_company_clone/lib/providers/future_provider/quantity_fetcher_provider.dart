import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final quantityFetcher = FutureProvider.family<int, String>((ref, serviceName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final phone = prefs.getString('user_phone');
  print(phone);
  DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('cart').doc(phone).get();
  int quantity = 0;
  if (documentSnapshot.exists) {
    final data = documentSnapshot.data() as Map<String, dynamic>;
    final serviceData = data[serviceName] as Map<String, dynamic>?;
    if (serviceData != null && serviceData.containsKey('quantity')) {
      quantity = serviceData['quantity'] as int;
      print('Found quantity: $quantity');
      return quantity;

    }
    return quantity;
  } else {
    print('No data found');
    return quantity;
  }
});


