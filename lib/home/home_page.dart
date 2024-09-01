import 'package:flutter/material.dart';
import 'package:flutter_boardview/board_item.dart';
import 'package:flutter_boardview/board_list.dart';
import 'package:flutter_boardview/boardview.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/home/home_controller.dart';
import 'package:todo_list/models/board_item_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: SafeArea(
        child: Obx(
          () => BoardView(
            lists: List.generate(
              c.boardListItems.length,
              (boardListIndex) {
                List<BoardItemModel> items =
                    c.boardListItems[boardListIndex].items;
                return BoardList(
                  draggable: false,
                  header: [
                    const SizedBox(width: 8),
                    Text(c.boardListItems[boardListIndex].name),
                    const SizedBox(width: 8),
                    Obx(() => Text('${items.length}')),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          c.titleController.text = '';
                          c.contentController.text = '';
                          c.authorController.text = '';
                          Get.dialog(
                            AlertDialog(
                              content: Form(
                                key: c.formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('제목'),
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      controller: c.titleController,
                                      decoration: InputDecoration(
                                        hintText: '무엇을 완료해야 합니까?',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return '*제목을 입력해주세요.';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    const Text('내용'),
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      controller: c.contentController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      maxLines: 3,
                                      decoration: InputDecoration(
                                        hintText: '내용',
                                        constraints:
                                            const BoxConstraints.expand(
                                                width: 600, height: 96),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return '*내용을 입력해주세요.';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Text('작성자'),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: TextFormField(
                                            controller: c.authorController,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (String? value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return '*작성자를 입력해주세요.';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () => c.addTask(items),
                                    child: const Text('등록'))
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.add)),
                  ],
                  items: List.generate(
                    items.length,
                    (index) {
                      return BoardItem(
                        index: 1,
                        onDropItem: (listIndex, itemIndex, oldListIndex,
                            oldItemIndex, state) {
                          // 내부 item 위치 변경
                          BoardItemModel item = c.boardListItems[oldListIndex!]
                              .items[oldItemIndex!];
                          c.boardListItems[oldListIndex].items
                              .removeAt(oldItemIndex);
                          c.boardListItems[listIndex!].items
                              .insert(itemIndex!, item);

                          // 드래그 중인 아이템 UI변화를 위해 상태변경
                          c.boardListItems[listIndex].items[itemIndex].isHovered
                              .value = false;
                        },
                        onStartDragItem: (listIndex, itemIndex, state) {
                          // 드래그 중인 아이템 UI변화를 위해 상태변경
                          c.boardListItems[listIndex!].items[itemIndex!]
                              .isHovered.value = true;
                        },
                        onTapItem: (listIndex, itemIndex, state) {
                          c.titleController.text = items[index].title;
                          c.contentController.text = items[index].content;
                          c.authorController.text = items[index].author;
                          Get.dialog(
                            AlertDialog(
                              content: Form(
                                key: c.formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('제목'),
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      controller: c.titleController,
                                      decoration: InputDecoration(
                                        hintText: '무엇을 완료해야 합니까?',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return '*제목을 입력해주세요.';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    const Text('내용'),
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      controller: c.contentController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      maxLines: 3,
                                      decoration: InputDecoration(
                                        hintText: '내용',
                                        constraints:
                                            const BoxConstraints.expand(
                                                width: 600, height: 96),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return '*내용을 입력해주세요.';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Text('작성자'),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: TextFormField(
                                            controller: c.authorController,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (String? value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return '*작성자를 입력해주세요.';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Text('최초 작성일'),
                                        const SizedBox(width: 10),
                                        Text(DateFormat('yyyy-MM-dd')
                                            .format(items[index].createdAt)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () => c.deleteTask(items, index),
                                    child: const Text('삭제')),
                                TextButton(
                                    onPressed: () => c.editTask(items, index),
                                    child: const Text('수정'))
                              ],
                            ),
                          );
                        },
                        item: Obx(
                          () => Container(
                            margin: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: items[index].isHovered.value
                                  ? Border.all(color: Colors.black, width: 2)
                                  : Border.all(color: Colors.white, width: 2),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  items[index].title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        items[index].author,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Icon(Icons.account_circle)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
