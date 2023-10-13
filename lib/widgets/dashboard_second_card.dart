import 'package:flutter/material.dart';

class DashboardSecondCard extends StatefulWidget {
  const DashboardSecondCard({
    super.key,
    required this.cardName,
    required this.number,
  });

  final String cardName;
  final int number;

  @override
  State<DashboardSecondCard> createState() => _DashboardSecondCardState();
}

class _DashboardSecondCardState extends State<DashboardSecondCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 140,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.teal,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 24.0,
            right: 16.0,
            left: 16.0,
            bottom: 16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.number.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  // ignore: prefer_const_constructors
                  Opacity(
                    opacity: 0.5,
                    child: const Icon(
                      Icons.insert_page_break_outlined,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Text(
                widget.cardName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
