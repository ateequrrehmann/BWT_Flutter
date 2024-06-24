import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_4_todo_app_using_sqlite/screens/calendar.dart';
import 'package:task_4_todo_app_using_sqlite/screens/homeScreen.dart';


void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
    routes: {
      '/Home': (context) => const HomeScreen(),
    },
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    TaskCalendar(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF363636),
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: _currentIndex == 0
                ? Icon(CupertinoIcons.house_fill)
                : Icon(CupertinoIcons.house),
            label: 'Index',
            tooltip: 'Go to Index',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 1
                ? Icon(CupertinoIcons.calendar_circle_fill)
                : Icon(CupertinoIcons.calendar_circle),
            label: 'Calendar',
            tooltip: 'View Calendar',
          ),
          // BottomNavigationBarItem(
          //   icon: _currentIndex == 2
          //       ? Icon(CupertinoIcons.person_fill)
          //       : Icon(CupertinoIcons.person),
          //   label: 'Profile',
          //   tooltip: 'See Profile',
          // ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }
}



