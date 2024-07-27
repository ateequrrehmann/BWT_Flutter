import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/models/services_model.dart';
import 'package:myapp/providers/future_provider/cleaning_services_data_provider.dart';
import 'package:myapp/providers/future_provider/home_services_data_provider.dart';
import 'package:myapp/providers/future_provider/user_data_provider.dart';
import 'package:myapp/providers/provider/adminEditPanel/admin_edit_provider.dart';

class AdminServiceEdit extends ConsumerStatefulWidget {
  final ServicesModel model;
  final String baseDoc;
  final String collectionName;
  const AdminServiceEdit({super.key, required this.model, required this.baseDoc, required this.collectionName});

  @override
  ConsumerState<AdminServiceEdit> createState() => _AdminServiceEditState();
}

class _AdminServiceEditState extends ConsumerState<AdminServiceEdit> {
  Uint8List? _image;
  String? imageUrl;
  bool check=false;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child){
      final data=ref.watch(adminEdit(widget.model));
      return Scaffold(
        appBar: AppBar(
          title: Text('Edit'),
        ),
        body: ListView(
          children: [
            const SizedBox(height: 50),
            Center(
              child: Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                    radius: 64,
                    backgroundImage: MemoryImage(_image!),
                  )
                      : data.imageUrl != ''  && data.imageUrl.isNotEmpty
                      ? CircleAvatar(
                    radius: 64,
                    backgroundImage:
                    NetworkImage('${data.imageUrl}'),
                  )
                      : CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage('${data.imageUrl}'),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: () async {
                        Uint8List img = await pickImage(ImageSource.gallery);
                        setState(() {
                          _image = img;
                        });
                        await saveData(_image!, widget.collectionName, widget.baseDoc);
                        Map<String, dynamic> serviceData = {
                          'serviceName': widget.model.serviceName,
                          'available': widget.model.available,
                          'per': widget.model.per,
                          'price': widget.model.price,
                          'rating': widget.model.rating,
                          'picture': imageUrl,
                        };
                        await FirebaseFirestore.instance.collection(widget.collectionName)
                            .doc(widget.baseDoc)
                            .update({widget.model.serviceName: serviceData,});
                        setState(() {
                          if(widget.collectionName=='HomeServices'){
                            ref.invalidate(homeServicesProvider);
                          }
                          else{
                            ref.invalidate(cleaningServicesProvider);
                          }
                          ref.invalidate(adminEdit(widget.model));
                        });
                      },
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Text(
                'Product details',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            buildDetailField('Service Name', data.serviceName, () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("can't change the name"),
                ),
              );
            }),
            buildDetailField('Rating', data.rating, () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("can't change the rating"),
                ),
              );
            }),
            buildDetailField('Per', data.per, () async {
              String newValue = "";
              await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: const Color(0xFFE9EBEB),
                    title: Text("Edit Per"),
                    content: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: "Enter new per",
                      ),
                      onChanged: (value) {
                        newValue = value;
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(newValue);
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ));
              if (newValue.trim().isNotEmpty) {
                Map<String, dynamic> serviceData = {
                  'serviceName': widget.model.serviceName,
                  'available': widget.model.available,
                  'per': newValue,
                  'price': widget.model.price,
                  'rating': widget.model.rating,
                  'picture': widget.model.imageUrl,
                };
                await FirebaseFirestore.instance.collection(widget.collectionName)
                    .doc(widget.baseDoc)
                    .update({widget.model.serviceName: serviceData,});
                setState(() {
                  if(widget.collectionName=='HomeServices'){
                    ref.invalidate(homeServicesProvider);
                  }
                  else{
                    ref.invalidate(cleaningServicesProvider);
                  }
                  ref.invalidate(adminEdit(widget.model));
                });
              }
            }),
            buildDetailField('Price', data.price, () async {
              String newValue = "";
              await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: const Color(0xFFE9EBEB),
                    title: Text("Edit price"),
                    content: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: "Enter new price",
                      ),
                      onChanged: (value) {
                        newValue = value;
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(newValue);
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ));
              if (newValue.trim().isNotEmpty) {
                Map<String, dynamic> serviceData = {
                  'serviceName': widget.model.serviceName,
                  'available': widget.model.available,
                  'per': widget.model.per,
                  'price': newValue,
                  'rating': widget.model.rating,
                  'picture': widget.model.imageUrl,
                };
                await FirebaseFirestore.instance.collection(widget.collectionName)
                    .doc(widget.baseDoc)
                    .update({widget.model.serviceName: serviceData,});
                setState(() {
                  if(widget.collectionName=='HomeServices'){
                    ref.invalidate(homeServicesProvider);
                  }
                  else{
                    ref.invalidate(cleaningServicesProvider);
                  }
                  ref.invalidate(adminEdit(widget.model));
                });
              }


            }),
            buildDetailField('Available', data.available.toString(), () async {
              bool newValue = data.available;

              await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: const Color(0xFFE9EBEB),
                  title: Text("Edit Availability"),
                  content: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return DropdownButton<bool>(
                        value: newValue,
                        items: [
                          DropdownMenuItem(
                            child: Text("True"),
                            value: true,
                          ),
                          DropdownMenuItem(
                            child: Text("False"),
                            value: false,
                          ),
                        ],
                        onChanged: (bool? value) {
                          setState(() {
                            newValue = value!;
                            check=newValue;
                          });
                        },
                      );
                    },
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(newValue);
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              );

              Map<String, dynamic> serviceData = {
                'serviceName': widget.model.serviceName,
                'available': newValue,
                'per': widget.model.per,
                'price': widget.model.price,
                'rating': widget.model.rating,
                'picture': widget.model.imageUrl,
              };
              await FirebaseFirestore.instance.collection(widget.collectionName)
                  .doc(widget.baseDoc)
                  .update({widget.model.serviceName: serviceData,});

              setState(() {
                if(widget.collectionName=='HomeServices'){
                  ref.invalidate(homeServicesProvider);
                }
                else{
                  ref.invalidate(cleaningServicesProvider);
                }
                ref.invalidate(adminEdit(widget.model));
              });
            }),

          ],
        ),
      );
    });

  }
  Widget buildDetailField(String label, String? value, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(left: 15, bottom: 15),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(color: Colors.white),),
              IconButton(
                onPressed: onPressed,
                icon: const Icon(Icons.settings, color: Colors.white,),
              ),
            ],
          ),
          Text(
            value ?? '',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
  pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    var file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("No image selected"),
      ),
    );
  }

  Future<String> uploadImageToStorage(String collection, String Doc, Uint8List file) async {
    Reference ref =
    FirebaseStorage.instance.ref().child(collection).child(Doc);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  Future<void> saveData(Uint8List file, String collection, String Doc) async {
    imageUrl = await uploadImageToStorage(collection, Doc, file);
  }
}
