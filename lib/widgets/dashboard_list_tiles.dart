import 'package:flutter/material.dart';
import 'package:graphqlgetxexample/widgets/dashboard_list_item.dart';

class DashboardListTiles extends StatefulWidget {
  const DashboardListTiles({super.key});

  @override
  State<DashboardListTiles> createState() => _DashboardListTilesState();
}

class _DashboardListTilesState extends State<DashboardListTiles> {
  @override
  Widget build(BuildContext context) {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: <Widget>[
        const DashboardListItem(),
        const DashboardListItem(),
        const DashboardListItem(),
        const DashboardListItem(),
      ],
    );
  }
}
