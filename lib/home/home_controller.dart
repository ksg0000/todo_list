import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/models/board_item_model.dart';
import 'package:todo_list/models/board_list_model.dart';

class HomeController extends GetxController {
  // 할 일
  final tasks = <BoardItemModel>[].obs;
  // 급한 일
  final urgentTasks = <BoardItemModel>[].obs;
  // 진행 중
  final onProgressTasks = <BoardItemModel>[].obs;
  // 완료
  final completedTasks = <BoardItemModel>[].obs;

  // BoardList 관리
  final boardListItems = <BoardListModel>[].obs;

  final formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController authorController = TextEditingController();

  final hover = false.obs;

  @override
  void onInit() {
    // 더미 데이터
    tasks.addAll([
      BoardItemModel(title: '여행가기', content: '일본 여행가기', author: '홍길동'),
      BoardItemModel(title: '요리하기', content: '볶음밥 요리하기', author: '김개똥'),
    ]);

    boardListItems.addAll([
      BoardListModel(name: '할 일', items: tasks),
      BoardListModel(name: '급한 일', items: urgentTasks),
      BoardListModel(name: '진행 중', items: onProgressTasks),
      BoardListModel(name: '완료', items: completedTasks),
    ]);
    super.onInit();
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    authorController.dispose();
    super.onClose();
  }

  void addTask(List<BoardItemModel> items) {
    if (formKey.currentState!.validate()) {
      items.add(
        BoardItemModel(
          title: titleController.text.trim(),
          content: contentController.text.trim(),
          author: authorController.text.trim(),
        ),
      );
      if (Get.isDialogOpen == true) Get.back();
    }
  }

  void editTask(List<BoardItemModel> items, int index) {
    if (formKey.currentState!.validate()) {
      items[index] = BoardItemModel(
        title: titleController.text.trim(),
        content: contentController.text.trim(),
        author: authorController.text.trim(),
      );

      if (Get.isDialogOpen == true) Get.back();
    }
  }

  void deleteTask(List<BoardItemModel> items, int index) {
    items.removeAt(index);
    if (Get.isDialogOpen == true) Get.back();
  }
}
