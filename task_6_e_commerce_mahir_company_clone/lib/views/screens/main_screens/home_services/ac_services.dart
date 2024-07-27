import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/providers/future_provider/home_services_data_provider.dart';
import 'package:myapp/views/reusable_widgets/reusableCardForServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../providers/future_provider/quantity_fetcher_provider.dart';
import '../../../shimmer_effect/services_card_skeleton.dart';

class ACServices extends ConsumerStatefulWidget {
  const ACServices({super.key});

  @override
  ConsumerState<ACServices> createState() => _ACServicesState();
}

class _ACServicesState extends ConsumerState<ACServices> {

  int gQuantity=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    ref.invalidate(homeServicesProvider('ac_services'));
    return Scaffold(
      appBar: AppBar(
        title: Text('AC SERVICES'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final service = ref.watch(homeServicesProvider('ac_services'));
          return service.when(
            data: (serviceData) {
              return ListView.builder(
                itemCount: serviceData.length,
                itemBuilder: (context, index) {
                  final data = serviceData[index];
                  final quantityAsyncValue = ref.watch(quantityFetcher(data.serviceName));

                  final quantityValue = quantityAsyncValue.maybeWhen(
                    data: (quantity) => quantity,
                    orElse: () => 0, // default value or placeholder
                  );
                  // fetchData(data.serviceName);
                  // if(previousQuantity!=0 && previousQuantity!=quantityValue){
                  //   ref.invalidate(quantityFetcher(data.serviceName));
                  // }
                  // previousQuantity=quantityValue;

                  return reusableCardForServices(
                    context,
                    data.serviceName,
                    data.per,
                    data.price,
                    data.rating,
                    data.imageUrl,
                    data.available,
                    'ac_services','HomeServices',
                    quantityValue,
                  );
                },
              );
            },
            error: (error, track) {
              return Center(child: Text('Error: $error'));
            },
            loading: () {
              return ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => const ServicesCardSkeleton(),
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemCount: 5,
              );
            },
          );
        },
      ),
    );
  }
  Future<void> fetchData(String serviceName) async{
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
      }
      gQuantity=quantity;
    } else {
      print('No data found');
      gQuantity=quantity;
    }
  }
}
