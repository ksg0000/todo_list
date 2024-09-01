import 'package:get/get.dart';
import 'package:todo_list/models/board_item_model.dart';

class BoardListModel {
  BoardListModel({required this.name, required this.items});

  String name; // 리스트 header 이름
  List<BoardItemModel> items; // 리스트 항목들
}
