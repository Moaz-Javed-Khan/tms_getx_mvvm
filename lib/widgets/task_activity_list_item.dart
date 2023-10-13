import 'package:flutter/material.dart';

class TaskActivityListItem extends StatefulWidget {
  const TaskActivityListItem({super.key});

  @override
  State<TaskActivityListItem> createState() => _TaskActivityListItemState();
}

class _TaskActivityListItemState extends State<TaskActivityListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: ExpansionTile(
          backgroundColor: Colors.tealAccent[200],
          collapsedBackgroundColor: Colors.tealAccent[100],
          iconColor: Colors.black,
          textColor: Colors.black,
          title: const Text('New task'),
          subtitle: const Text('31 July 2023'),
          children: <Widget>[
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const SizedBox(width: 14),
                const Icon(
                  Icons.warning_rounded,
                ),
                const SizedBox(width: 10),
                const Text(
                  "Rafay",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            const ListTile(
              title: Text('Details'),
              subtitle: Text('Created new team: Lenovo'),
            ),
          ],
        ),
      ),
    );
  }
}
