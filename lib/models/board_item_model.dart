import 'package:get/get_rx/src/rx_types/rx_types.dart';

class BoardItemModel {
  BoardItemModel({
    required this.title,
    required this.content,
    required this.author,
  })  : createdAt = DateTime.now(),
        isHovered = false.obs;

  String title; // 제목
  String content; // 내용
  String author; // 담당자
  DateTime createdAt; // 날짜
  RxBool isHovered; // 드래그 중인 아이템 UI변화를 위한 변수
}
