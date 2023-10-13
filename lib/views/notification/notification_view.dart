import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView>
    with SingleTickerProviderStateMixin {
  void _runAnimation() async {
    for (int i = 0; i < 3; i++) {
      await _animationController.forward();
      await _animationController.reverse();
    }
  }

  late AnimationController _animationController;

  Timer? timer;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    // timer = Timer.periodic(
    //   const Duration(seconds: 2),
    //   (Timer t) => _runAnimation(),
    // );

    // _runAnimation();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Stack(
            //   children: [
            //     Container(
            //       decoration: const BoxDecoration(
            //         color: Colors.grey,
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(10),
            //         ),
            //       ),
            //       width: double.infinity,
            //       height: 10,
            //     ),
            //     Container(
            //       decoration: const BoxDecoration(
            //         color: Colors.blue,
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(10),
            //         ),
            //       ),
            //       width: 150,
            //       height: 10,
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 10),
            const Text(
              "No notification",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            RotationTransition(
              turns: Tween(begin: 0.0, end: -.1)
                  .chain(
                    CurveTween(curve: Curves.elasticIn),
                  )
                  .animate(_animationController),
              child: const Icon(
                Icons.notifications_off,
                size: 32,
              ),
            ),
            TextButton(
              child: const Text("Flutter Bottom Sheet"),
              onPressed: () {
                _showBottomSheet(context);
              },
            ),
            TextButton(
              child: const Text("GetX Bottom Sheet"),
              onPressed: () {
                Get.bottomSheet(
                  Container(
                      height: 150,
                      color: Colors.tealAccent,
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text('Notification 1', textScaleFactor: 2),
                          const Text('Notification 2', textScaleFactor: 2),
                          const Text('Notification 3', textScaleFactor: 2),
                          const Text('Notification 4', textScaleFactor: 2),
                        ],
                      )),
                  // barrierColor: Colors.red[50],
                  // isDismissible: false,
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(35),
                  //     side: const BorderSide(width: 5, color: Colors.black)),
                  // enableDrag: false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    print(width);
    print(height);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Stack(
              children: [
                const ListTile(
                  tileColor: Colors.teal,
                  title: Text(
                    'Notification',
                  ),
                  subtitle: Text("Number of Notification"),
                  trailing: Text("Hellloooo"),
                ),
                Transform.translate(
                  offset: Offset((width * 0.833), -32),
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: RotationTransition(
                      turns: Tween(begin: 0.0, end: -.1)
                          .chain(
                            CurveTween(curve: Curves.elasticIn),
                          )
                          .animate(_animationController),
                      child: const Icon(
                        Icons.notifications,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const ListTile(
              title: Text('Notification 1'),
            ),
            const ListTile(
              title: Text('Notification 2'),
            ),
            const ListTile(
              title: Text('Notification 3'),
            ),
            const ListTile(
              title: Text('Notification 4'),
            ),
            const ListTile(
              title: Text('Notification 5'),
            ),
            const ListTile(
              title: Text('Notification 6'),
            ),
          ],
        );
      },
    );
  }
}
