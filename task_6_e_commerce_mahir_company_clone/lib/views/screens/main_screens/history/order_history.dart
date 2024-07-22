import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myapp/providers/future_provider/history_provider.dart';
import 'package:myapp/providers/future_provider/quantity_fetcher_provider.dart';
import 'package:myapp/views/reusable_widgets/reusableSnackBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../providers/future_provider/cart_provider.dart';
import '../../../shimmer_effect/services_card_skeleton.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<HistoryScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.invalidate(historyProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final data = ref.watch(historyProvider);
          return data.when(data: (orderData) {
            ref.watch(historyProvider);
            return ListView.builder(
                itemCount: orderData.length,
                itemBuilder: (context, index) {
                  final data = orderData[index];
                  final formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(data.dateTime);
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
                                    'Ckeckout time $formattedDate',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
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
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Text('Quantity ${data.quantity.toString()}'),
                                      ),

                                    ],
                                  ),
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
