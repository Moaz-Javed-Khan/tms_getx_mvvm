// board view

class BoardListObject {
  String title;

  List<BoardItemObject> items;

  BoardListObject({
    required this.title,
    required this.items,
  });
}

class BoardItemObject {
  String title;

  String from;

  BoardItemObject({
    required this.title,
    required this.from,
  });
}
