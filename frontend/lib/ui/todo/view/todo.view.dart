import 'package:cutie_todo_app/ui/todo/cubit/todo.cubit.dart';
import 'package:cutie_todo_app/ui/todo/view/widgets/add_task_bottom_sheet.dart';
import 'package:cutie_todo_app/ui/todo/view/widgets/custom_checkbox.dart';
import 'package:cutie_todo_app/ui/todo/view/widgets/todo_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(),
      child: const TodoView(),
    );
  }
}

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const Gap(kToolbarHeight),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  icon: Container(
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                const Gap(15),
                const Text(
                  'Tasks',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const Spacer(),
                PopupMenuButton(
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Colors.grey,
                    size: 30,
                  ),
                  position: PopupMenuPosition.under,
                  itemBuilder: (context) {
                    return const [
                      PopupMenuItem(
                        child: Text(''),
                      ),
                    ];
                  },
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                  top: 30,
                ),
                child: Column(
                  children: const [
                    ExpansionTile(
                      initiallyExpanded: true,
                      title: Text(
                        'Thins to do - 10:',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      iconColor: Colors.white,
                      collapsedIconColor: Colors.white,
                      children: [
                        TodoTile(),
                        TodoTile(),
                        TodoTile(),
                      ],
                    ),
                    ExpansionTile(
                      title: Text(
                        'Completed - 10:',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      iconColor: Colors.white,
                      collapsedIconColor: Colors.white,
                      children: [
                        TodoTile(),
                        TodoTile(),
                        TodoTile(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<String>(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            builder: (context) {
              return const AddTaskBottomSheet();
            },
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
