import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:graphqlgetxexample/views/dashboard/dashboard.dart';
import 'package:graphqlgetxexample/views/notification/notification_view.dart';
import 'package:graphqlgetxexample/views/account/profile_view.dart';
import 'package:graphqlgetxexample/views/taskActivity/task_activity_view.dart';
import 'package:graphqlgetxexample/views/teamboard/teamboard.dart';
import 'package:graphqlgetxexample/widgets/side_drawer.dart';
import 'package:graphqlgetxexample/widgets/side_drawer_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final screens = [
    const NotificationView(),
    const Dashboard(),
    const Teamboard(),
    const TaskActivityView(),
    ProfileView(),
  ];

  int _selectedIndex = 0;
  // late PageController _pageController;

  @override
  void initState() {
    super.initState();
    // _pageController = PageController(initialPage: _selectedIndex);
  }

  // @override
  // void dispose() {
  //   _pageController.dispose();
  //   super.dispose();
  // }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      //using this page controller you can make beautiful animation effects
      // _pageController.animateToPage(
      //   index,
      //   duration: const Duration(seconds: 1),
      //   curve: Curves.ease,
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("Page ${_selectedIndex + 1}"),
        title: _selectedIndex == 0
            ? const Text("Notifications")
            : _selectedIndex == 1
                ? const Text("Dashboard")
                : _selectedIndex == 2
                    ? const Text("Teams")
                    : _selectedIndex == 3
                        ? const Text("Activities")
                        : const Text("Profile"),
        centerTitle: true,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.teal,
        onTap: _onItemTapped,
        // ignore: prefer_const_literals_to_create_immutables
        items: <Widget>[
          const Icon(Icons.notifications),
          const Icon(Icons.dashboard),
          const Icon(Icons.group_rounded),
          const Icon(Icons.work_rounded),
          const Icon(Icons.account_circle),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   unselectedItemColor: Colors.black,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.notifications),
      //       label: 'Notifications',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.dashboard),
      //       label: 'Dashboard',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.group_rounded),
      //       label: 'Teamboard',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.work_rounded),
      //       label: 'Task Activity',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.account_circle),
      //       label: 'Profile',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.tealAccent,
      //   onTap: _onItemTapped,
      // ),
      body: AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        child: screens[_selectedIndex],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: SingleChildScrollView(
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const SideDrawerHeader(),
                const SideDrawer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
