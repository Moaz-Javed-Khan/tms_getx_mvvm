import 'package:flutter/material.dart';
import 'package:graphqlgetxexample/widgets/dashboard_first_card_item.dart';

class DashboardFirstCard extends StatefulWidget {
  const DashboardFirstCard({super.key});

  @override
  State<DashboardFirstCard> createState() => _DashboardFirstCardState();
}

class _DashboardFirstCardState extends State<DashboardFirstCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.tealAccent[100],
        elevation: 1,
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    DashboardFirstCardItem(
                      itemIcon: const Icon(Icons.abc_sharp),
                      itemName: "Total Completed Rate",
                      itemPercentage: 10.0,
                    ),
                    DashboardFirstCardItem(
                      itemIcon: const Icon(Icons.view_comfortable_sharp),
                      itemName: "Total Response Rate",
                      itemPercentage: 10.0,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    DashboardFirstCardItem(
                      itemIcon: const Icon(Icons.home),
                      itemName: "Overdue Task",
                      itemPercentage: 90.0,
                    ),
                    DashboardFirstCardItem(
                      itemIcon: const Icon(Icons.access_alarms_outlined),
                      itemName: "Task Reassigned Rate",
                      itemPercentage: 0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
