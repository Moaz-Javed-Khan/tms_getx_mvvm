import 'package:flutter/material.dart';
import 'package:graphqlgetxexample/widgets/dashboard_slider_item.dart';

class DashboardSlider extends StatefulWidget {
  const DashboardSlider({super.key});

  @override
  State<DashboardSlider> createState() => _DashboardSliderState();
}

class _DashboardSliderState extends State<DashboardSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const DashBoardSliderItem(
            cardName: "Tasks in Progress",
            number: 7,
          ),
          const DashBoardSliderItem(
            cardName: "Tasks Completed",
            number: 10,
          ),
          const DashBoardSliderItem(
            cardName: "Tasks Assigned",
            number: 2,
          ),
        ],
      ),
    );
  }
}
