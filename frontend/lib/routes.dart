import 'package:cutie_todo_app/ui/auth/views/auth_page.dart';
import 'package:cutie_todo_app/ui/todo/view/todo.view.dart';
import 'package:go_router/go_router.dart';

///
final router = GoRouter(
  initialLocation: '/auth',
  routes: [
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthView(),
    ),
    GoRoute(
      path: '/todos',
      builder: (context, state) => const TodoView(),
    ),
  ],
);
