import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graphqlgetxexample/Utils/Routing.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          // backgroundColor: Colors.tealAccent[200],
          // collapsedBackgroundColor: Colors.tealAccent[100],
          // iconColor: Colors.black,
          // textColor: Colors.black,
          leading: const Icon(Icons.supervised_user_circle_rounded),
          title: const Text('User Management'),
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: const ListTile(
                title: Text('User Dashboard'),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.push('/userLov');
                context.pop();
              },
              child: const ListTile(
                title: Text('Users'),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.push("/allUsers");
                context.pop();
              },
              child: const ListTile(
                title: Text('All Users'),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const ListTile(
                title: Text('Create User'),
              ),
            ),
          ],
        ),
        ExpansionTile(
          // backgroundColor: Colors.tealAccent[200],
          // collapsedBackgroundColor: Colors.tealAccent[100],
          // iconColor: Colors.black,
          // textColor: Colors.black,
          leading: const Icon(Icons.group),
          title: const Text('Team Management'),
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: const ListTile(
                title: Text('Team Dashboard'),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const ListTile(
                title: Text('Teams'),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const ListTile(
                title: Text('Create Team'),
              ),
            ),
          ],
        ),
        ExpansionTile(
          // backgroundColor: Colors.tealAccent[200],
          // collapsedBackgroundColor: Colors.tealAccent[100],
          // iconColor: Colors.black,
          // textColor: Colors.black,
          leading: const Icon(Icons.local_activity),
          title: const Text('Activity'),
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: const ListTile(
                title: Text('Activity Log'),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const ListTile(
                title: Text('Action Activity'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
