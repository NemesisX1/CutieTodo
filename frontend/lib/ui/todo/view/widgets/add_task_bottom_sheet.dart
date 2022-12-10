import 'package:cutie_todo_app/ui/todo/cubit/todo.cubit.dart';
import 'package:cutie_todo_app/ui/widgets/custom_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

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
      body: LayoutBuilder(builder: (context, constraints) {
        return Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
            ),
            constraints: kIsWeb
                ? BoxConstraints(
                    maxWidth: constraints.maxWidth > 600
                        ? 500
                        : MediaQuery.of(context).size.width,
                  )
                : null,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height:
                          MediaQuery.of(context).size.height - kToolbarHeight,
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
                          CustomTextField(
                            title: 'Title',
                            controller: todoState.state.titleController,
                          ),
                          const Gap(10),
                          CustomTextField(
                            title: 'Description',
                            controller: todoState.state.descriptionController,
                          ),
                          const Gap(10),
                          CustomTextField(
                            title: 'Starting time',
                            controller: todoState.state.startTimeController,
                            readonly: true,
                            suffix: const Icon(
                              Icons.calendar_month,
                              color: Colors.white,
                            ),
                            onTap: () async {
                              final dateTime = await showOmniDateTimePicker(
                                context: context,
                                startFirstDate: DateTime.now(),
                                startLastDate: DateTime.now().add(
                                  const Duration(
                                    hours: 24 * 365,
                                  ),
                                ),
                                unselectedTabBackgroundColor:
                                    Colors.pink.shade400,
                                primaryColor: Colors.pink.shade400,
                              );
                              if (dateTime != null) {
                                todoState.setStartDate(dateTime);

                                todoState.state.startTimeController.text =
                                    '''${DateFormat('yyyy/MM/dd').format(dateTime)} at ${DateFormat('HH:mm a').format(dateTime)}''';
                              }
                            },
                          ),
                          const Gap(10),
                          CustomTextField(
                            title: 'Ending time',
                            readonly: true,
                            controller: todoState.state.endTimeController,
                            suffix: const Icon(
                              Icons.calendar_month,
                              color: Colors.white,
                            ),
                            onTap: () async {
                              final dateTime = await showOmniDateTimePicker(
                                context: context,
                                startFirstDate: DateTime.now(),
                                startLastDate: DateTime.now().add(
                                  const Duration(
                                    hours: 24 * 365,
                                  ),
                                ),
                                unselectedTabBackgroundColor:
                                    Colors.pink.shade400,
                                primaryColor: Colors.pink.shade400,
                              );
                              if (dateTime != null) {
                                todoState.setEndDate(dateTime);

                                todoState.state.endTimeController.text =
                                    '''${DateFormat('yyyy/MM/dd').format(dateTime)} at ${DateFormat('HH:mm a').format(dateTime)}''';
                              }
                            },
                          ),
                          const Gap(20),
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
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.8,
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                                          todoState
                                                              .state
                                                              .tagsController
                                                              .text,
                                                        );
                                                        todoState.state
                                                            .tagsController
                                                            .clear();
                                                        Navigator.of(context)
                                                            .pop();
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
      }),
    );
  }
}
