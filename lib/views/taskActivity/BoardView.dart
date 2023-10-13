// import 'package:boardview/boardview.dart';
// import 'package:flutter/material.dart';
// import 'package:graphqlgetxexample/models/kanban_board_view_model.dart';
// import 'package:boardview/board_item.dart';
// import 'package:boardview/board_list.dart';
// import 'package:boardview/boardview_controller.dart';

// final List<BoardListObject> _listData = [
//   BoardListObject(
//     title: "Task 1",
//     items: [
//       BoardItemObject(title: "abc abc", from: "moaz"),
//     ],
//   ),
//   BoardListObject(
//     title: "Task 2",
//     items: [
//       BoardItemObject(title: "abc abc", from: "ali"),
//       BoardItemObject(title: "xyz xyz", from: "ahmed"),
//     ],
//   ),
//   BoardListObject(
//     title: "Task 3",
//     items: [
//       BoardItemObject(title: "xyz xyz", from: "uzair"),
//       BoardItemObject(title: "rff dty", from: "sami"),
//       BoardItemObject(title: "abc abc", from: "osama"),
//     ],
//   ),
// ];

// class BoardViewDetail extends StatelessWidget {
//   BoardViewDetail({super.key});

//   final BoardViewController boardViewController = BoardViewController();

//   @override
//   Widget build(BuildContext context) {
//     List<BoardList>? _lists;

//     for (int i = 0; i < _listData.length; i++) {
//       _lists!.add(_createBoardList(_listData[i]));
//     }
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: BoardView(
//         lists: _lists,
//         boardViewController: boardViewController,
//       ),
//     );
//   }
// }

// BoardItem buildBoardItem(BoardItemObject itemObject) {
//   return BoardItem(
//       onStartDragItem: (
//         int? listIndex,
//         int? itemIndex,
//         BoardItemState state,
//       ) {},
//       onDropItem: (
//         int? listIndex,
//         int? itemIndex,
//         int? oldListIndex,
//         int? oldItemIndex,
//         BoardItemState? state,
//       ) {
//         //Used to update our local item data
//         var item = _listData[oldListIndex!].items[oldItemIndex!];

//         _listData[oldListIndex].items.removeAt(oldItemIndex);

//         _listData[listIndex!].items.insert(itemIndex!, item);
//       },
//       onTapItem:
//           (int? listIndex, int? itemIndex, BoardItemState? state) async {},
//       item: Container(
//         margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
//         child: Card(
//           elevation: 0,
//           child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     itemObject.from,
//                     style: const TextStyle(
//                       height: 1.5,
//                       color: Color(0xff2F334B),
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10.0,
//                   ),
//                   Text(
//                     itemObject.title,
//                     style: const TextStyle(
//                       height: 1.5,
//                       color: Color(0xff2F334B),
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               )),
//         ),
//       ));
// }

// BoardList _createBoardList(BoardListObject list) {
//   List<BoardItem>? items;
//   for (int i = 0; i < list.items.length; i++) {
//     items!.insert(i, buildBoardItem(list.items[i]));
//   }

//   return BoardList(
//     onStartDragList: (int? listIndex) {},
//     onTapList: (int? listIndex) async {},
//     onDropList: (
//       int? listIndex,
//       int? oldListIndex,
//     ) {
//       //Update our local list data
//       var list = _listData[oldListIndex!];
//       _listData.removeAt(oldListIndex);
//       _listData.insert(listIndex!, list);
//     },
//     headerBackgroundColor: Colors.transparent,
//     backgroundColor: const Color(0xffECEDFC),
//     header: [
//       Expanded(
//         child: Container(
//           padding: const EdgeInsets.all(10),
//           child: Text(
//             list.title,
//             style: const TextStyle(
//               fontSize: 23,
//               fontWeight: FontWeight.bold,
//               color: Color(0xff2F334B),
//             ),
//           ),
//         ),
//       ),
//     ],
//     items: items,
//   );
// }
