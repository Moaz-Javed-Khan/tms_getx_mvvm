import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:graphqlgetxexample/views/taskActivity/BoardView.dart';
import 'package:graphqlgetxexample/widgets/kanban.dart';
import 'package:graphqlgetxexample/widgets/shimmer_list_item.dart';
import 'package:graphqlgetxexample/widgets/task_activity_list_item.dart';
import 'package:shimmer/shimmer.dart';

class TaskActivityView extends StatefulWidget {
  const TaskActivityView({super.key});

  @override
  State<TaskActivityView> createState() => _TaskActivityViewState();
}

class _TaskActivityViewState extends State<TaskActivityView>
    with TickerProviderStateMixin {
  bool isLoading = true;

  @override
  void initState() {
    final group1 = AppFlowyGroupData(
      id: "To Do",
      items: [
        TextItem("Card 111111111111"),
        TextItem("Card 2"),
      ],
      name: 'To Do',
    );
    final group2 = AppFlowyGroupData(
      id: "In Progress",
      items: [
        TextItem("Card 3"),
        TextItem("Card 4"),
      ],
      name: 'In Progress',
    );

    final group3 = AppFlowyGroupData(
      id: "Done",
      items: [],
      name: 'Done',
    );

    controller.addGroup(group1);
    controller.addGroup(group2);
    controller.addGroup(group3);

    Future.delayed(
      const Duration(seconds: 2),
      () {
        setState(() {
          isLoading = false;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:

          //  Column(
          //   children: [
          Kanban(),
      // Container(
      //   height: 300,
      //   color: Colors.green[300],
      //   child: AppFlowyBoard(
      //     // background: const ColoredBox(color: Colors.blue),
      //     controller: controller,
      //     cardBuilder: (context, group, groupItem) {
      //       final textItem = groupItem as TextItem;
      //       return AppFlowyGroupCard(
      //         key: ObjectKey(textItem),
      //         child: Text(textItem.s),
      //       );
      //     },
      //     groupConstraints: const BoxConstraints.tightFor(width: 200),
      //   ),
      // ),

      // isLoading
      //     ? getShimmerLoading()
      //     :

      //  Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     mainAxisSize: MainAxisSize.min,
      //     // ignore: prefer_const_literals_to_create_immutables
      //     children: [
      //       const Text(
      //         "All Tasks Activity",
      //         style: TextStyle(
      //           fontSize: 16,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),

      // Expanded(
      //     child: ListView.builder(
      //       itemCount: 6,
      //       itemBuilder: (context, index) {
      //         return const TaskActivityListItem();
      //       },
      //     ),
      //   ),

      //   ],
      // ),
      //   ],
      // ),
    );
  }

  final AppFlowyBoardController controller = AppFlowyBoardController(
    onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move item from $fromIndex to $toIndex');
    },
    onMoveGroupItem: (groupId, fromIndex, toIndex) {
      debugPrint('Move $groupId:$fromIndex to $groupId:$toIndex');
    },
    onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move $fromGroupId:$fromIndex to $toGroupId:$toIndex');
    },
  );

  Shimmer getShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
                color: Colors.white,
              ),
              width: 150,
              height: 20,
            ),
            const SizedBox(height: 10),
            const ShimmerListItem(),
            const SizedBox(height: 10),
            const ShimmerListItem(),
            // const SizedBox(height: 10),
            // const ShimmerListItem(),
            // const SizedBox(height: 10),
            // const ShimmerListItem(),
            // const SizedBox(height: 10),
            // const ShimmerListItem(),
            // const SizedBox(height: 10),
            // const ShimmerListItem(),
          ],
        ),
      ),

      //     ExpansionTile(
      //   title: const Text('New task'),
      //   subtitle: const Text('31 July 2023'),
      //   children: <Widget>[
      //     Row(
      //       // ignore: prefer_const_literals_to_create_immutables
      //       children: [
      //         const SizedBox(width: 14),
      //         const Icon(
      //           Icons.warning_rounded,
      //         ),
      //         const SizedBox(width: 10),
      //         const Text(
      //           "Rafay",
      //           style: TextStyle(
      //             fontSize: 18,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         )
      //       ],
      //     ),
      //     const ListTile(
      //       title: Text('Details'),
      //       subtitle: Text('Created new team: Lenovo'),
      //     ),
      //   ],
      // ),
    );
  }
}

class TextItem extends AppFlowyGroupItem {
  final String s;
  TextItem(this.s);

  @override
  String get id => s;
}
