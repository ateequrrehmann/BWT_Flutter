import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentScreen extends StatefulWidget {
  final String userId;
  final String role;
  final String classCode;

  const StudentScreen(
      {super.key,
        required this.userId,
        required this.role,
        required this.classCode});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final TextEditingController _classNameController = TextEditingController();

  Future<Map<String, dynamic>?> fetchClassData() async {
    DocumentSnapshot documentSnapshot =
    await FirebaseFirestore.instance.collection('users').doc(widget.userId).get();
    return documentSnapshot.data() as Map<String, dynamic>?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('People'),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: fetchClassData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data found'));
          } else {
            Map<String, dynamic> data = snapshot.data!;
            List<String> students = List<String>.from(data['students']);
            String instructor = data['username'];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Instructor: $instructor',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Students:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(students[index]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
