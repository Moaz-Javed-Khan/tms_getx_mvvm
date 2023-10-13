import 'package:flutter/material.dart';

class TeamboardCard extends StatefulWidget {
  const TeamboardCard({
    super.key,
    required this.cardName,
    required this.number,
  });

  final String cardName;
  final int number;

  @override
  State<TeamboardCard> createState() => _TeamboardCardState();
}

class _TeamboardCardState extends State<TeamboardCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 140,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.tealAccent,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            right: 12.0,
            left: 12.0,
            bottom: 12.0,
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
                maxLines: 2,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
