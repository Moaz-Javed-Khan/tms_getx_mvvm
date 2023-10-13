import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DashboardFirstCardItem extends StatelessWidget {
  DashboardFirstCardItem({
    super.key,
    required this.itemIcon,
    required this.itemPercentage,
    required this.itemName,
  });

  Icon itemIcon;
  double itemPercentage;
  String itemName;

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_literals_to_create_immutables
    return SizedBox(
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            maxRadius: 14,
            child: Opacity(
              opacity: 0.4,
              child: Icon(
                itemIcon.icon,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 6),
          // ignore: prefer_const_constructors
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${itemPercentage.toString()}%",
                // ignore: prefer_const_constructors
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                itemName,
                // ignore: prefer_const_constructors
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
