import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClassworkScreen extends StatefulWidget {
  final String userId;
  final String role;
  final String classCode;

  const ClassworkScreen({
    required this.userId,
    required this.role,
    required this.classCode,
  });

  @override
  State<ClassworkScreen> createState() => _ClassworkScreenState();
}

class _ClassworkScreenState extends State<ClassworkScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late String _priorityController = "1";
  late String _statusController = "Pending";
  final TextEditingController _completionDateController =
      TextEditingController();
  bool isChecked = false;
  TextEditingController _timeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic>? classData;
  List<DocumentSnapshot> classes = [];


  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future<void> selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
    uploadFile();
  }

  Future<void> uploadFile() async{
    final path='files/${pickedFile!.name}';
    final file=File(pickedFile!.path!);
    final ref=FirebaseStorage.instance.ref().child(path);

    setState(() {
      uploadTask=ref.putFile(file);
    });
    final snapshot=await uploadTask!.whenComplete(() {});
    final urlDownload =await snapshot.ref.getDownloadURL();
    print('Download link $urlDownload');
    setState(() {
      uploadTask=null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('File uploaded successfully!'),
      ),
    );
  }

  Future<void> fetchTask() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('tasks').get();
    setState(() {
      classes = querySnapshot.docs;
      print('hell');
      print(classes);
    });
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
        title: Text('Classwork'),
      ),
      body: classes.isEmpty
          ? Center(child: Text('No data found'))
          : ListView.builder(
            itemCount: classes.length,
            itemBuilder: (context, index) {
              var classData = classes[index].data() as Map<String, dynamic>;
              var docId = classes[index].id;
              return Card(
                margin: EdgeInsets.all(10.0),
                child: ListTile(
                  title: Text(
                    classData['title'] ?? '',
                    style: TextStyle(fontSize: 15),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(height: 5),
                      Text('${classData['description'] ?? ''}'),
                      Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text('Due Date: ${classData['date'] ?? ''}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 80),
                          child: Text('Time: ${classData['time'] ?? ''}'),
                        ),
                      ],
                  ),
                  trailing: widget.role.toLowerCase() == "teacher"
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                // Add your custom edit function here
                                taskForm(docId);
                                fetchTask();
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('tasks')
                                    .doc(docId)
                                    .delete();
                                _messageForm("Task deleted successfully");
                                fetchTask();
                              },
                              icon: Icon(CupertinoIcons.delete_solid),
                            ),
                          ],
                        )
                      : null,
                ),
              );
            },
          ),
      floatingActionButton: widget.role.toLowerCase()=="teacher"
      ?FloatingActionButton(
        onPressed: () {
          taskForm(null); // Add new task
        },
        child: Icon(CupertinoIcons.add),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF8687E7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        tooltip: 'Add task',
      ):null,
    );
  }

  void taskForm(String? id) async {
    if (id != null) {
      // Fetch existing task data from Firestore and populate the form
      DocumentSnapshot taskSnapshot =
          await FirebaseFirestore.instance.collection('tasks').doc(id).get();
      var taskData = taskSnapshot.data() as Map<String, dynamic>;
      if (taskData != null) {
        setState(() {
          _titleController.text = taskData['title'] ?? '';
          _descriptionController.text = taskData['description'] ?? '';
          _timeController.text = taskData['time'] ?? '';
          _completionDateController.text = taskData['date'] ?? '';
        });
      }
    }

    // Show modal bottom sheet for adding/editing task
    showModalBottomSheet<dynamic>(
      backgroundColor: Color(0xFF363636),
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.8, // Takes half of the screen
        child: Container(
          padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      id != null ? 'Edit Task' : 'Add Task',
                      style: TextStyle(
                        color: Color(0xDEFFFFFF),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: TextFormField(
                        controller: _titleController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Title can\'t be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle:
                              TextStyle(color: Color(0xDEFFFFFF), fontSize: 18),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                              color: Color(0xFF979797),
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
                          enabledBorder: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Color(0xDEFFFFFF),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle:
                              TextStyle(color: Color(0xDEFFFFFF), fontSize: 18),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                              color: Color(0xFF979797),
                            ),
                          ),
                          enabledBorder: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Color(0xDEFFFFFF),
                        ),
                      ),
                    ),
                    SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: _showTimePicker,
                          icon: Icon(
                            CupertinoIcons.timer,
                            color: Color(0xDEFFFFFF),
                          ),
                        ),
                        IconButton(
                          onPressed: selectFile,
                          icon: Icon(
                            CupertinoIcons.upload_circle_fill,
                            color: Color(0xDEFFFFFF),
                          ),
                        ),
                        IconButton(
                          onPressed: _selectData,
                          icon: Icon(
                            CupertinoIcons.tag,
                            color: Color(0xDEFFFFFF),
                          ),
                        ),
                        SizedBox(width: 135),
                        IconButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (id == null) {
                                // Add task
                                await FirebaseFirestore.instance
                                    .collection('tasks')
                                    .add({
                                  'title': _titleController.text,
                                  'description': _descriptionController.text,
                                  'time': _timeController.text,
                                  'date': _completionDateController.text,
                                  'classCode': widget.classCode,
                                });
                                Navigator.pop(context);
                                _messageForm("Task Added Successfully");
                                _titleController.text = '';
                                _descriptionController.text = '';
                              } else {
                                // Update task
                                await FirebaseFirestore.instance
                                    .collection('tasks')
                                    .doc(id)
                                    .update({
                                  'title': _titleController.text,
                                  'description': _descriptionController.text,
                                  'time': _timeController.text,
                                  'date': _completionDateController.text,
                                });
                                Navigator.pop(context);
                                _messageForm("Task Updated Successfully");
                                _titleController.text = '';
                                _descriptionController.text = '';
                              }
                            }
                          },
                          icon: Icon(
                            CupertinoIcons.arrowtriangle_right_fill,
                            color: Color(0xDEFFFFFF),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showTimePicker() async {
    await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        final formattedTime = value.format(context);
        setState(() {
          _timeController.text = formattedTime;
          print(_timeController.text);
        });
      }
    });
  }

  Future<void> _selectData() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (_picked != null) {
      setState(() {
        _completionDateController.text = _picked.toString().split(" ")[0];
        print(_completionDateController.text);
      });
    }
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
