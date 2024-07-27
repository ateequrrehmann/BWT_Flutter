import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/services_model.dart';

final adminEdit = Provider.family<ServicesModel, ServicesModel>((ref, doc) {
  return ServicesModel(
      serviceName: doc.serviceName,
      per: doc.per,
      price: doc.price,
      imageUrl: doc.imageUrl,
      rating: doc.rating,
      available: doc.available);
});
