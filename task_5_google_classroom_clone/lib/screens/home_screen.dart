import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String userId;
  const Home({super.key, required this.userId});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String role="unknown";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ClassNameController=TextEditingController();
  final TextEditingController _SectionController=TextEditingController();
  final TextEditingController _SubjectController=TextEditingController();
  final TextEditingController _RoomController=TextEditingController();
  late String classCode;
  List<DocumentSnapshot> classes = [];

  @override
  void initState() {
    super.initState();
    fetchUserRole(widget.userId);
    fetchClasses(widget.userId);
  }

  Future<void> fetchUserRole(String? id) async{
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(id).get();
    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
    role=userData['role'];
    print(role);
  }

  Future<void> fetchClasses(String userId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('classes')
        .get();
    setState(() {
      classes = querySnapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Google', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),),
            SizedBox(width: 4,),
            Text('Classroom', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black38),)
          ],
        ),
        elevation: 2.0,
        backgroundColor: Colors.white70,
        toolbarOpacity: 0.8,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text(
                  "A",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
          ),
        ],
      ),


      body: classes.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: classes.length,
        itemBuilder: (context, index) {
          var classData = classes[index].data() as Map<String, dynamic>;
          return Card(
            margin: EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(
                classData['class_name'],
                style: TextStyle(fontSize: 30),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 5),
                  Text('${classData['Section'] ?? ''}'),
                  SizedBox(height: 65),
                  Text('${classData['Subject'] ?? ''}'),
                  // Text('Room: ${classData['Room'] ?? ''}'),
                  // Text('Class Code: ${classData['classCode'] ?? ''}'),
                ],
              ),
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(CupertinoIcons.delete_solid),
                  ),
                ],
              ),
            ),
          );
        },
      ),


        floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(role=="Student"){
            print(role);
          }
          else{
            print(role);
            TeacherClassCreation(null);
          }
        },
        child: Icon(CupertinoIcons.add),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF8687E7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        tooltip: 'Add Task',
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        elevation: 20.0,
        child: ListView(
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 50.0),
              child: ListTile(
                title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('G', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),),
                  Text('o', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),),
                  Text('o', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 20),),
                  Text('g', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),),
                  Text('l', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),),
                  Text('e', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),),
                  SizedBox(width: 4,),
                  Text('Classroom', style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold, fontSize: 20),)

                ],
              ),
              ),
            ),
            Divider(height: 0.1,),
            ListTile(
              title: Text(
                "Classes",
              ),
              leading: Icon(Icons.home),
            ),
            //Divider(height: 0.1,),
            ListTile(
              title: Text(
                "Calendar",
              ),
              leading: Icon(Icons.calendar_today),
            ),
            //Divider(height: 0.1,),
            ListTile(
              title: Text(
                "Notifications",
              ),
              leading: Icon(Icons.notifications),
            ),
            Divider(height: 0.1,),
            SizedBox(height: 2,),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 0, 2),
              child: Text('ENROLLED', style: TextStyle(fontSize: 13),),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 2, 0, 2),
              child: ListTile(
                title: Text(
                  "To-do",
                ),
                leading: Icon(Icons.task),
              ),
            ),
            Divider(height: 0.1,),
            ListTile(
              title: Text(
                "Offline files",
              ),
              leading: Icon(Icons.check_circle_outline_rounded),
            ),
            ListTile(
              title: Text(
                "Archived classes",
              ),
              leading: Icon(Icons.archive_outlined),
            ),
            ListTile(
              title: Text(
                "Classroom folders",
              ),
              leading: Icon(Icons.folder),
            ),
            ListTile(
              title: Text(
                "Settings",
              ),
              leading: Icon(Icons.settings),
            ),
            ListTile(
              title: Text(
                "Help",
              ),
              leading: Icon(Icons.help_outline),
            ),
          ],
        ),
      ),
    );
  }
  void TeacherClassCreation(String? id) async{
    if (id != null) {
      // final existingTasks = _tasks.firstWhere((element) => element['id'] == id);
      // _titleController.text = existingTasks['title'];
      // _descriptionController.text = existingTasks['description'];
      // _priorityController = existingTasks['priority'];
      // _completionDateController.text = existingTasks['completionDate'];
      // _timeController.text = existingTasks['time'];
    }
    showModalBottomSheet<dynamic>(
      // backgroundColor: Color(0xFF363636),
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.9,
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
                      'Class Creation',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: TextFormField(
                        controller: _ClassNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Title can\'t be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Class Name',
                          labelStyle:
                          TextStyle(fontSize: 18),
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
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: TextFormField(
                        controller: _SectionController,
                        decoration: InputDecoration(
                          labelText: 'Section',
                          labelStyle:
                          TextStyle(fontSize: 18),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                              color: Color(0xFF979797),
                            ),
                          ),
                          enabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: TextFormField(
                        controller: _SubjectController,
                        decoration: InputDecoration(
                          labelText: 'Subject',
                          labelStyle:
                          TextStyle(fontSize: 18),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                              color: Color(0xFF979797),
                            ),
                          ),
                          enabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: TextFormField(
                        controller: _RoomController,
                        decoration: InputDecoration(
                          labelText: 'Room',
                          labelStyle:
                          TextStyle(fontSize: 18),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                              color: Color(0xFF979797),
                            ),
                          ),
                          enabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                            onPressed: (){
                              if (_formKey.currentState!.validate()) {
                                if(id==null){
                                  classCode=generateCode();
                                  print(classCode);
                                    FirebaseFirestore.instance.collection('users').doc(widget.userId).collection('classes').doc().set({
                                      'class_name': _ClassNameController.text,
                                      'Section': _SectionController.text??'',
                                      'Subject': _SubjectController.text??'',
                                      'Room': _RoomController.text??'',
                                      'classCode': classCode,
                                      // Add more fields as needed
                                    }).then((_) {
                                      print("class added for teacher");
                                      fetchClasses(widget.userId);
                                    }).catchError((error) {
                                      print("Failed to add class: $error");
                                    });

                                  //await _addTask();
                                  Navigator.pop(context);
                                  _messageForm("Class Added Successfully");
                                  _ClassNameController.text='';
                                  _SectionController.text='';
                                  _SubjectController.text='';
                                  _RoomController.text='';
                                }
                                if(id!=null){
                                  //await _updateTask(id);
                                  Navigator.pop(context);
                                  _messageForm("Class Updated Successfully");
                                  _ClassNameController.text='';
                                  _SectionController.text='';
                                  _SubjectController.text='';
                                  _RoomController.text='';
                                }

                              }
                            },
                            child: Text('Save')
                        ),

                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  String generateCode() {
    int length=7;
    const String _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }
  void _messageForm(String? message){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
              builder: (context, setState){
                return AlertDialog(
                  title: Text('$message', style: TextStyle(color: Color(0xDEFFFFFF)),),
                  backgroundColor: Color(0xFF363636),
                  actions: [
                    ElevatedButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.pop(
                            context); // Close the dialog
                      },
                    ),
                  ],
                );

              }
          );
        }
    );
  }
}


