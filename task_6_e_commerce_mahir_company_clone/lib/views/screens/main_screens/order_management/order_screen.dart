import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/providers/future_provider/quantity_fetcher_provider.dart';
import 'package:myapp/views/reusable_widgets/reusableSnackBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../providers/future_provider/cart_provider.dart';
import '../../../shimmer_effect/services_card_skeleton.dart';

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({super.key});

  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.invalidate(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Order'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final data = ref.watch(cartProvider);
          return data.when(data: (orderData) {
            final service = ref.watch(cartProvider);
            return ListView.builder(
                itemCount: orderData.length,
                itemBuilder: (context, index) {
                  final data = orderData[index];
                  return Card(
                    color: Colors.white70,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height: 120,
                              width: 120,
                              child: Image.network(data.imageUrl),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.serviceName,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16 / 2),
                                    child: Text(
                                      data.per,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8 / 2),
                                    child: Row(
                                      children: [
                                        Icon(Icons.star),
                                        Text(
                                          data.rating,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left: 20)),
                                        IconButton(
                                                onPressed: () async {
                                                  SharedPreferences prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  final phone = prefs
                                                      .getString('user_phone');
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('cart')
                                                      .doc(phone)
                                                      .update({
                                                    data.serviceName:
                                                        FieldValue.delete(),
                                                  });
                                                  print(
                                                      'Service ${data.serviceName} deleted');
                                                  ref.invalidate(cartProvider);
                                                  reusableSnackBar(context,  'Service ${data.serviceName} deleted');
                                                  ref.invalidate(quantityFetcher(data.serviceName));
                                                },
                                                icon:
                                                    Icon(Icons.delete_forever)),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        ("Rs.${data.totalPrice}"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                      // Padding(
                                      //   padding: EdgeInsets.symmetric(
                                      //       horizontal: 8 / 2),
                                      //   child: CircleAvatar(
                                      //     radius: 3,
                                      //     backgroundColor: Colors.grey,
                                      //   ),
                                      // ),
                                      // TextButton(
                                      //   onPressed: () {
                                      //     setState(() {
                                      //       if (data.quantity > 0) {
                                      //         data.quantity--;
                                      //       }
                                      //     });
                                      //
                                      //     print(data.quantity);
                                      //   },
                                      //   child: Icon(Icons.remove),
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Text('Quantity ${data.quantity.toString()}'),
                                      ),
                                      // TextButton(
                                      //   onPressed: () {
                                      //     setState(() {
                                      //       data.quantity++;
                                      //     });
                                      //     print(data.quantity);
                                      //   },
                                      //   child: Icon(Icons.add),
                                      // ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                });
          }, error: (error, track) {
            return Center(child: Text('checking+$error'));
          }, loading: () {
            return ListView.separated(
                itemBuilder: (context, index) => const ServicesCardSkeleton(),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 16,
                    ),
                itemCount: 5);
          });
        },
      ),
    );
  }
}
