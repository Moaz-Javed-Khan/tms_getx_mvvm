import 'package:flutter/material.dart';

class TweenAnimationPage extends Page {
  final Widget child;

  const TweenAnimationPage({required this.child})
      : super(key: const ValueKey('TweenAnimationPage'));

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
