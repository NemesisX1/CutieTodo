import 'package:cutie_todo_app/ui/todo/cubit/todo.state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoState());
}
