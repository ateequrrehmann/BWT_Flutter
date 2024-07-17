import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/services_model.dart';

final homeServicesProvider = FutureProvider.family<List<ServicesModel>, String>(
    (ref, documentName) async {
  final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
      .collection('HomeServices')
      .doc(documentName)
      .get();
  final data = documentSnapshot.data() as Map<String, dynamic>;
  final List<ServicesModel> services = data.entries.map((entry) {
    final serviceData = entry.value as Map<String, dynamic>;
    print(serviceData);
    return ServicesModel(
        serviceName: serviceData['serviceName']??'',
        per: serviceData['per']??'',
        price: serviceData['price']??'',
        imageUrl: serviceData['picture']??'',
        rating: serviceData['rating']??'',
        available: serviceData['available']??true);
  }).toList();
  return services;
});
