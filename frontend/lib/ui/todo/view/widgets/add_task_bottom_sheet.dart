import 'package:cutie_todo_app/ui/todo/cubit/todo.cubit.dart';
import 'package:cutie_todo_app/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  _AddTaskBottomSheetState createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final todoState = context.read<TodoCubit>();
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - kToolbarHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Text(
                        'Add a new task',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      const Gap(20),
                      const CustomTextField(
                        title: 'Title',
                      ),
                      const Gap(10),
                      const CustomTextField(
                        title: 'Description',
                      ),
                      const Gap(10),
                      const Text(
                        'Tags',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const Gap(10),
                      Row(
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.8,
                            ),
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                ...List<Widget>.generate(
                                    todoState.state.tags.length, (index) {
                                  return Card(
                                    color: Colors.pinkAccent.shade400,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        context
                                            .read<TodoCubit>()
                                            .state
                                            .tags[index],
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                                Card(
                                  color: Colors.pink.shade400,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      showDialog<void>(
                                        context: context,
                                        builder: (context) {
                                          return SimpleDialog(
                                            contentPadding:
                                                const EdgeInsets.all(15),
                                            backgroundColor: Colors.grey,
                                            children: [
                                              CustomTextField(
                                                controller: todoState
                                                    .state.tagsController,
                                              ),
                                              const Gap(20),
                                              ElevatedButton(
                                                onPressed: () {
                                                  if (todoState
                                                      .state
                                                      .tagsController
                                                      .text
                                                      .isNotEmpty) {
                                                    todoState.addTag(
                                                      todoState.state
                                                          .tagsController.text,
                                                    );
                                                    todoState
                                                        .state.tagsController
                                                        .clear();
                                                    Navigator.of(context).pop();
                                                  }
                                                },
                                                child: const Text('Add'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Add task'),
            ),
            const Gap(40),
          ],
        ),
      ),
    );
  }
}
