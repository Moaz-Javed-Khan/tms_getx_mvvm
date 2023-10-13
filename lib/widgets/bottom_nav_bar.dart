// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';
// import 'package:go_router/go_router.dart';
// import 'package:graphqlgetxexample/Utils/Routing.dart';
// import 'package:graphqlgetxexample/views/dashboard/dashboard.dart';
// import 'package:graphqlgetxexample/views/notification/notification_view.dart';
// import 'package:graphqlgetxexample/views/account/profile_view.dart';
// import 'package:graphqlgetxexample/views/taskActivity/task_activity_view.dart';
// import 'package:graphqlgetxexample/views/teamboard/teamboard.dart';
// import 'package:graphqlgetxexample/widgets/side_drawer.dart';
// import 'package:graphqlgetxexample/widgets/side_drawer_header.dart';

// class BottomNavShell extends StatefulWidget {
//   final Widget child;

//   const BottomNavShell({super.key, required this.child});

//   @override
//   State<BottomNavShell> createState() => _BottomNavShellState();
// }

// class _BottomNavShellState extends State<BottomNavShell> {
//   final screens = [
//     const NotificationView(),
//     const Dashboard(),
//     const Teamboard(),
//     const TaskActivityView(),
//     ProfileView(),
//   ];

//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;

//       switch (index) {
//         case 0:
//           context.go(NOTIFICATION_VIEW);
//           break;
//         case 1:
//           context.go(DASHBOARD);
//           break;
//         case 2:
//           context.go(TEAMBOARD);
//           break;
//         case 3:
//           context.go(TEAM_ACTIVITY);
//           break;
//         case 4:
//           context.go(PROFILE);
//           break;
//         // Add cases for other routes
//       }

//       //using this page controller you can make beautiful animation effects
//       // _pageController.animateToPage(
//       //   index,
//       //   duration: const Duration(seconds: 1),
//       //   curve: Curves.ease,
//       // );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         print("before: $_selectedIndex");
//         if (_selectedIndex != 0) {
//           setState(() {
//             _selectedIndex = 0;
//           });
//           print("after: $_selectedIndex");
//           _onItemTapped(_selectedIndex);

//           return false;
//         } else {
//           return true;
//         }
//       },
//       child: Scaffold(
//         bottomNavigationBar: CurvedNavigationBar(
//           backgroundColor: Colors.white,
//           color: Colors.teal,
//           onTap: _onItemTapped,
//           // ignore: prefer_const_literals_to_create_immutables
//           items: <Widget>[
//             const Icon(Icons.notifications),
//             const Icon(Icons.dashboard),
//             const Icon(Icons.group_rounded),
//             const Icon(Icons.work_rounded),
//             const Icon(Icons.account_circle),
//           ],
//         ),
//         appBar: AppBar(
//           title: _selectedIndex == 0
//               ? const Text("Notifications")
//               : _selectedIndex == 1
//                   ? const Text("Dashboard")
//                   : _selectedIndex == 2
//                       ? const Text("Teams")
//                       : _selectedIndex == 3
//                           ? const Text("Activities")
//                           : const Text("Profile"),
//           centerTitle: true,
//         ),
//         drawer: Drawer(
//           backgroundColor: Colors.white,
//           child: Padding(
//             padding: const EdgeInsets.only(top: 30.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 // ignore: prefer_const_literals_to_create_immutables
//                 children: [
//                   const SideDrawerHeader(),
//                   const SideDrawer(),
//                 ],
//               ),
//             ),
//           ),
//         ),

//         // body: AnimatedSwitcher(
//         //   duration: const Duration(seconds: 1),
//         //   child: screens[_selectedIndex],
//         // ),

//         body: AnimatedSwitcher(
//           duration: const Duration(seconds: 2),
//           child: widget.child,
//         ),
//       ),
//     );
//   }
// }
