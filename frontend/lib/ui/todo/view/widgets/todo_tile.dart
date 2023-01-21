import 'package:cutie_todo_app/core/models/todo.model.dart';
import 'package:cutie_todo_app/ui/todo/view/widgets/custom_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TodoTile extends StatefulWidget {
  const TodoTile({
    super.key,
    this.task,
  });

  final Todo? task;

  @override
  _TodoTileState createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  bool _taskIsDone = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return IntrinsicHeight(
          child: Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: CustomCheckbox(
                      isChecked: _taskIsDone,
                      onChanged: (value) {
                        setState(() {
                          _taskIsDone = !value;
                        });
                      },
                    ),
                  ),
                  const Gap(15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          // maxWidth: constraints.maxWidth > 400 : 350,
                          maxWidth: constraints.maxWidth > 500
                              ? 350
                              : MediaQuery.of(context).size.width * 0.6,
                        ),
                        child: Text(
                          'Finish the essay about collaboratio dd qsqsd qsd qd n',
                          maxLines: 3,
                          softWrap: true,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            decoration: !_taskIsDone
                                ? null
                                : TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                      const Gap(5),
                      Row(
                        children: const [
                          Icon(
                            Icons.calendar_month,
                            color: Colors.greenAccent,
                            size: 20,
                          ),
                          Gap(5),
                          Text(
                            'Today',
                            style: TextStyle(
                              color: Colors.greenAccent,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
