import 'package:cutie_todo_app/ui/todo/cubit/todo.cubit.dart';
import 'package:cutie_todo_app/ui/todo/view/widgets/add_task_bottom_sheet.dart';
import 'package:cutie_todo_app/ui/todo/view/widgets/todo_tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
      body: LayoutBuilder(builder: (context, constraints) {
        return Center(
          child: Container(
            constraints: kIsWeb
                ? BoxConstraints(
                    maxWidth: constraints.maxWidth > 600
                        ? 600
                        : MediaQuery.of(context).size.width,
                  )
                : null,
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
                        return [
                          PopupMenuItem(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                    'https://avatars.githubusercontent.com/u/55746329?v=4',
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    launchUrlString(
                                        'https://github.com/NemesisX1');
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    foregroundColor: Colors.pinkAccent,
                                  ),
                                  child: const Text(
                                    'Made with love 💙 by NemesisX1',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    launchUrlString(
                                        'https://github.com/NemesisX1/CutieTodo');
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.pinkAccent,
                                  ),
                                  child: Text(
                                    'Full code here',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.pink.shade400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ];
                      },
                    ),
                  ],
                ),
                if (kIsWeb) ...[
                  const Gap(30),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet<String>(
                        context: context,
                        isScrollControlled: true,
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
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.pink.shade400,
                                width: 4,
                              ),
                              color: Colors.pink.shade400,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.add),
                          ),
                          const Gap(10),
                          const Text(
                            'Add a task',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(
                      top: 30,
                    ),
                    child: Wrap(
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: kIsWeb
          ? null
          : FloatingActionButton(
              onPressed: () {
                showModalBottomSheet<String>(
                  context: context,
                  isScrollControlled: true,
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
