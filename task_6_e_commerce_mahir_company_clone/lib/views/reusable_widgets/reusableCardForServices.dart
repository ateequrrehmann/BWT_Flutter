import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget reusableCardForServices(BuildContext context, String serviceName, String per, String price, String imageUrl, bool available  ){
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
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16 / 2),
                    child: Text(
                      per,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Row(
                    children:  [
                      Text(
                        price,
                      ),
                      Padding(padding: EdgeInsets.only(left: 95)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16/2),
                        child: CircleAvatar(
                          radius: 3,
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      TextButton(
                          onPressed: (){},
                          child: Row(
                            children: [
                              Text('add'),
                              Icon(Icons.add),
                            ],
                          )
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
}