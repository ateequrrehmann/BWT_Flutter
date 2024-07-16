import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/views/reusable_widgets/reusableCardForServices.dart';

class ACServices extends StatefulWidget {
  const ACServices({super.key});

  @override
  State<ACServices> createState() => _ACServicesState();
}

class _ACServicesState extends State<ACServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello'),
      ),
      body: Column(
        children: [
          reusableCardForServices(
              context,
              'Hello',
              'asdfasd',
              '200',
              'https://firebasestorage.googleapis.com/v0/b/mahircompanyclone.appspot.com/o/default_image%2Favatar.png?alt=media&token=1c65efe5-cb3c-4a6e-9fff-3e0ed9e5b661',
              true),
        ],
      ),
    );
  }
}
