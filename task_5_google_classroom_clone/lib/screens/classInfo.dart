import 'package:flutter/material.dart';
import 'package:task_5_google_classroom_clone/screens/classwork_screen.dart';
import 'package:task_5_google_classroom_clone/screens/student_screen.dart';

import 'index_screen.dart';

class ClassInfo extends StatefulWidget {
  final String userId;
  final String role;
  final String classCode;
  const ClassInfo({super.key, required this.userId, required this.role, required this.classCode});

  @override
  State<ClassInfo> createState() => _ClassInfoState();
}

class _ClassInfoState extends State<ClassInfo> {
  int _currentIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      IndexScreen(userId: widget.userId, role: widget.role, classCode: widget.classCode,),
      ClassworkScreen(userId: widget.userId, role: widget.role, classCode: widget.classCode,),
      StudentScreen(userId: widget.userId, role: widget.role, classCode: widget.classCode,)
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF363636),
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: _currentIndex == 0
                ? Icon(Icons.message)
                : Icon(Icons.message_outlined),
            label: 'Stream',
            tooltip: 'Go to Stream',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 1
                ? Icon(Icons.note)
                : Icon(Icons.note_outlined),
            label: 'Classwork',
            tooltip: 'View Classwork',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 2
                ? Icon(Icons.people)
                : Icon(Icons.people_alt_outlined),
            label: 'People',
            tooltip: 'See People',
          ),
        ],
      ),
    );
  }
}
