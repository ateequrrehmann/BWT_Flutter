import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  final String userId;
  final String role;
  final String docId;

  const TaskScreen(
      {super.key,
        required this.userId,
        required this.role,
        required this.docId});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  Map<String, dynamic>? classData;
  List<dynamic> comments = [];

  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  final TextEditingController _commentController = TextEditingController();

  Future<void> selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
    uploadFile();
  }

  Future<void> uploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);

    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download link $urlDownload');

    setState(() {
      uploadTask = null;
    });

    // Show snackbar on successful upload
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('File uploaded successfully!'),
      ),
    );
  }

  Future<void> fetchTask() async {
    print(widget.docId);
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('tasks')
        .doc(widget.docId)
        .get();
    setState(() {
      classData = documentSnapshot.data() as Map<String, dynamic>?;
      comments = classData?['comments'] ?? [];
    });
    print(classData);
  }

  void addComment(String text) {
    setState(() {
      comments.add(text);
    });
    FirebaseFirestore.instance.collection('tasks').doc(widget.docId).update({
      'comments': comments
    });
    _commentController.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Info'),
      ),
      body: classData != null
          ? SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        classData!['title'] ?? 'No class name',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text('Description: ${classData!['description'] ?? ''}')
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text('Deadline: ${classData!['date'] ?? ''}')
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text('Time: ${classData!['time'] ?? ''}')
                    ],
                  ),
                  SizedBox(height: 200),
                  Text('Submit task', style: TextStyle(fontSize: 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          selectFile();
                        },
                        icon: Icon(Icons.upload, size: 30),
                      ),
                    ],
                  ),
                  uploadTask != null ? buildUploadStatus(uploadTask!) : Container(),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text('Comments'),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
                    child: TextFormField(
                      controller: _commentController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Can\'t be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'message to instructor',
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
                            String text = _commentController.text;
                            addComment(text);
                          },
                          child: Icon(Icons.arrow_forward),
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(comments[index]),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      )
          : Center(child: CircularProgressIndicator()),
    );
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
    stream: task.snapshotEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final snap = snapshot.data!;
        final progress = snap.bytesTransferred / snap.totalBytes;
        final percentage = (progress * 100).toStringAsFixed(2);

        return Column(
          children: [
            LinearProgressIndicator(
              value: progress,
            ),
            SizedBox(height: 10),
            Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        );
      } else {
        return Container();
      }
    },
  );
}