import 'dart:io';
import 'package:dart_deta_frog_todo_server/controllers/base.controller.dart';
import 'package:dart_deta_frog_todo_server/helpers/enums.dart';
import 'package:dart_deta_frog_todo_server/helpers/globals.dart';
import 'package:dart_deta_frog_todo_server/models/todo.model.dart';
import 'package:dart_deta_frog_todo_server/services/deta.service.dart';
import 'package:dart_frog/dart_frog.dart';

///
class TodoController implements BaseController {
  final _detaService = locator<DetaService>();

  ///
  Future<Response> create(Todo todo) async {
    try {
      final createdTodo = await _detaService.get<Todo>(name: DetaName.todos);

      return Response.json(
        statusCode: HttpStatus.created,
        body: createdTodo,
      );
    } catch (e) {
      logger.w('[TodoController]: Error on create(): $e');
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: e.toString(),
      );
    }
  }

  ///
  Future<Response> delete(String id) async {
    try {
      final result = await _detaService.delete<Todo>(
        name: DetaName.todos,
        key: id,
      );

      if (result) {
        return Response.json(
          statusCode: HttpStatus.accepted,
          body: '$id deleted',
        );
      }
      return Response.json(
        statusCode: HttpStatus.notFound,
      );
    } catch (e) {
      logger.w('[TodoController]: Error on delete(): $e');
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: e.toString(),
      );
    }
  }

  ///
  Future<Response> get() async {
    try {
      final todos = await _detaService.get<Todo>(name: DetaName.todos);

      return Response.json(
        body: todos,
      );
    } catch (e) {
      logger.w('[TodoController]: Error on get(): $e');
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: e.toString(),
      );
    }
  }

  ///
  Future<Response> getById(String id) async {
    try {
      final todo = await _detaService.getByKey<Todo>(
        name: DetaName.todos,
        key: id,
      );

      return Response.json(
        body: todo,
      );
    } catch (e) {
      logger.w('[TodoController]: Error on getByKey(): $e');
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: e.toString(),
      );
    }
  }

  ///
  Future<Response> update(String id, Todo todo) async {
    try {
      final updatedTodo = await _detaService.update<Todo>(
        name: DetaName.todos,
        key: id,
        data: todo,
      );

      return Response.json(
        body: updatedTodo,
      );
    } catch (e) {
      logger.w('[TodoController]: Error on getByKey(): $e');
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: e.toString(),
      );
    }
  }
}
