import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndexScreen extends StatefulWidget {
  final String userId;
  final String role;
  final String classCode;

  const IndexScreen(
      {super.key,
      required this.userId,
      required this.role,
      required this.classCode});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  Map<String, dynamic>? classData;
  List<DocumentSnapshot> classes = [];
  final TextEditingController _classNameController = TextEditingController();

  Future<void> fetchTask() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('tasks').get();
    setState(() {
      classes = querySnapshot.docs;
      print('hell');
      print(classes);
    });
  }

  Future<void> fetchClass() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .collection('classes')
        .doc(widget.classCode)
        .get();
    setState(() {
      classData = documentSnapshot.data() as Map<String, dynamic>?;
      print(classData);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchClass();
    fetchTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Class Information'),
      ),
      body: classData != null
              ? Column(
                  children: [
                    Card(
                      margin: EdgeInsets.all(10.0),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  classData!['class_name'] ?? 'No class name',
                                  style: TextStyle(fontSize: 30),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text('Section: ${classData!['Section'] ?? ''}')
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
                      child: TextFormField(
                        controller: _classNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Can\'t be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Announce',
                          hintText: 'Announce something to your class',
                          labelStyle: TextStyle(fontSize: 18),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                              color: Color(0xFF979797),
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                              color: Color(0xFF979797),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                              color: Color(0xFF979797),
                            ),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              String text = _classNameController.text;
                              print('Saving: $text');
                              _classNameController.clear();
                            },
                            child: Icon(Icons.arrow_forward),
                          ),
                        ),
                      ),
                    ),
                    classes.isEmpty
                        ? Center(child: Text('No data found'))
                        : Expanded(
                            child: ListView.builder(
                              itemCount: classes.length,
                              itemBuilder: (context, index) {
                                var classData = classes[index].data()
                                    as Map<String, dynamic>;
                                var docId = classes[index].id;
                                return Card(
                                  margin: EdgeInsets.all(10.0),
                                  child: ListTile(
                                    title: Text(
                                      classData['title'] ?? '',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(height: 5),
                                        Text(
                                            '${classData['description'] ?? ''}'),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Text(
                                              'Due Date: ${classData['date'] ?? ''}'),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 80),
                                          child: Text(
                                              'Time: ${classData['time'] ?? ''}'),
                                        ),
                                      ],
                                    ),
                                    // trailing: Row(
                                    //   mainAxisSize: MainAxisSize.min,
                                    //   children: [
                                    //     IconButton(
                                    //       onPressed: () {
                                    //         // Add your custom edit function here
                                    //       },
                                    //       icon: Icon(Icons.edit),
                                    //     ),
                                    //     IconButton(
                                    //       onPressed: () {
                                    //         FirebaseFirestore.instance
                                    //             .collection('users')
                                    //             .doc(docId)
                                    //             .delete();
                                    //         _messageForm("Class deleted successfully");
                                    //         fetchTask();
                                    //       },
                                    //       icon: Icon(CupertinoIcons.delete_solid),
                                    //     ),
                                    //   ],
                                    // ),
                                  ),
                                );
                              },
                            ),
                          ),
                  ],
                )
              : Center(child: CircularProgressIndicator()),
    );
  }

  void _messageForm(String? message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$message', style: TextStyle(color: Color(0xDEFFFFFF))),
          backgroundColor: Color(0xFF363636),
          actions: [
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
