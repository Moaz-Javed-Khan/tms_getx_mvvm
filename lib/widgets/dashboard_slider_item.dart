import 'package:flutter/material.dart';

class DashBoardSliderItem extends StatefulWidget {
  const DashBoardSliderItem({
    super.key,
    required this.cardName,
    required this.number,
  });

  final String cardName;
  final int number;

  @override
  State<DashBoardSliderItem> createState() => _DashBoardSliderItemState();
}

class _DashBoardSliderItemState extends State<DashBoardSliderItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width) * 0.66,
      height: 120,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    widget.number.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    widget.cardName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              // ignore: prefer_const_constructors
              Opacity(
                opacity: 0.5,
                child: const Icon(
                  Icons.article,
                  size: 48,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
