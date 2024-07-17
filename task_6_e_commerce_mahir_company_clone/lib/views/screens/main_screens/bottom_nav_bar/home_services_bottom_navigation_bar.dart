import 'package:flutter/material.dart';
import 'package:myapp/views/screens/main_screens/home_services/home_services.dart';
import 'package:myapp/views/screens/profile_screen/profile_screen.dart';

import '../order_management/order_screen.dart';

class HomeServicesBottomNavBar extends StatefulWidget {
  const HomeServicesBottomNavBar({super.key});

  @override
  State<HomeServicesBottomNavBar> createState() => _HomeServicesBottomNavBarState();
}

class _HomeServicesBottomNavBarState extends State<HomeServicesBottomNavBar> {
  int _currentIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeService(),
      OrderScreen(),
      ProfilePage(),
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
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: _currentIndex == 0
                ? Icon(Icons.home)
                : Icon(Icons.home_outlined),
            label: 'Home',
            tooltip: 'Go to Home',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 1
                ? Icon(Icons.list)
                : Icon(Icons.list_outlined),
            label: 'Order',
            tooltip: 'View Order',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 2
                ? Icon(Icons.person)
                : Icon(Icons.person_outlined),
            label: 'Profile',
            tooltip: 'See Profile',
          ),
        ],
      ),
    );
  }
}
