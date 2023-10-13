import 'package:flutter/material.dart';
import 'package:graphqlgetxexample/widgets/task_activity_list_item.dart';

class TaskActivityListTiles extends StatefulWidget {
  const TaskActivityListTiles({super.key});

  @override
  State<TaskActivityListTiles> createState() => _TaskActivityListTilesState();
}

class _TaskActivityListTilesState extends State<TaskActivityListTiles>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return TaskActivityListItem();
    // ListView.builder(
    //   itemCount: 10,
    //   itemBuilder: (BuildContext context, int index) {
    //     return const TaskActivityListItem();
    //   },
    // );
  }
}
