import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/views/reusable_widgets/reusableSnackBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget reusableCardForServices(
    BuildContext context,
    String serviceName,
    String per,
    String price,
    String rating,
    String imageUrl,
    bool available,
    String baseDocument,
    String baseCollection) {

  int quantityCount = 0; // Define quantityCount outside the StatefulBuilder
  double totalPrice = 0;

  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
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
                  child: Image.network(imageUrl),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        serviceName,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16 / 2),
                        child: Text(
                          per,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8 / 2),
                        child: Row(
                          children: [
                            Icon(Icons.star),
                            Text(
                              rating,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Padding(padding: EdgeInsets.only(left: 20)),
                            quantityCount > 0
                                ? TextButton(
                              onPressed: () async {
                                if (quantityCount > 0) {
                                  totalPrice =
                                      quantityCount * (double.parse(price));
                                }
                                SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                                final phone = prefs.getString('user_phone');
                                Map<String, dynamic> serviceData = {
                                  'available': true,
                                  'per': per,
                                  'price': price,
                                  'rating': rating,
                                  'picture': imageUrl,
                                  'baseDocument': baseDocument,
                                  'baseCollection': baseCollection,
                                  'quantity': quantityCount,
                                  'totalPrice': totalPrice,
                                };
                                final DocumentSnapshot documentSnapshot =
                                await FirebaseFirestore.instance
                                    .collection('cart')
                                    .doc(phone)
                                    .get();
                                print(documentSnapshot.exists);
                                if (documentSnapshot.exists) {
                                  FirebaseFirestore.instance
                                      .collection('cart')
                                      .doc(phone)
                                      .update({
                                    serviceName: serviceData,
                                  });
                                  print('existing');
                                } else {
                                  print('oops not available');
                                  FirebaseFirestore.instance
                                      .collection('cart')
                                      .doc(phone)
                                      .set({
                                    serviceName: serviceData,
                                  });
                                }
                                reusableSnackBar(context, 'service added to cart successfully');
                              },
                              child: Text('Add to cart'),
                            )
                                : Text(''),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            ("Rs.$price"),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8 / 2),
                            child: CircleAvatar(
                              radius: 3,
                              backgroundColor: Colors.grey,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                if (quantityCount > 0) {
                                  quantityCount--;
                                }
                              });
                              print(quantityCount);
                            },
                            child: Icon(Icons.remove),
                          ),
                          quantityCount > 0
                              ? Text(quantityCount.toString())
                              : Text('add'),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                quantityCount++;
                              });
                              print(quantityCount);
                            },
                            child: Icon(Icons.add),
                          ),

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
    },
  );
}
