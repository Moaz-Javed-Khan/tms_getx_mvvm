import 'package:flutter/material.dart';

class AnimatedLogo extends StatelessWidget {
  AnimatedLogo({
    Key? key,
    required this.controller,
    required this.turns,
    required this.taskFontInitial,
  }) : super(key: key);

  final double turns;
  final double taskFontInitial;
  AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 240,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: RotationTransition(
              // duration: const Duration(seconds: 4),
              turns: controller,
              child: Image.asset(
                "assets/gear.png",
                height: 130,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: RotationTransition(
              // duration: const Duration(seconds: 4),
              turns: controller,
              child: Image.asset(
                "assets/gear.png",
                height: 130,
              ),
            ),
          ),
          Positioned(
            top: 56,
            left: 20,
            child: Image.asset(
              "assets/magnifier.png",
              height: 164,
            ),
          ),
          Positioned(
              top: 104,
              left: 64,
              child: AnimatedDefaultTextStyle(
                duration: const Duration(seconds: 1),
                style: TextStyle(fontSize: taskFontInitial),
                child: const Text(
                  "Task",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
