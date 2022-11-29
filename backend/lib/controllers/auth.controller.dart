import 'dart:io';
import 'package:bcrypt/bcrypt.dart';
import 'package:cutie_todo_backend/controllers/base.controller.dart';
import 'package:cutie_todo_backend/helpers/enums.dart';
import 'package:cutie_todo_backend/helpers/globals.dart';
import 'package:cutie_todo_backend/models/user.model.dart';
import 'package:cutie_todo_backend/services/deta.service.dart';
import 'package:cutie_todo_backend/strategies/jwt_auth.strategy.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:deta/deta.dart';
import 'package:tuple/tuple.dart';

///
class AuthController extends BaseController {
  ///
  AuthController();

  final _detaService = locator<DetaService>();
  final _jwtStrategy = locator<JwtAuthStrategy>();

  /// check if the user already exist in DetaService
  Future<Tuple2<bool, User?>> validateUser(User user) async {
    try {
      final users = await _detaService.get<User>(
        name: DetaName.users,
        query: [
          DetaQuery('username').equalTo(user.username!),
        ],
      );
      if (users.isEmpty) {
        return const Tuple2(false, null);
      }
      return Tuple2(true, users.first);
    } catch (e) {
      return const Tuple2(false, null);
    }
  }

  ///
  Future<Response> signIn(User user) async {
    final userExist = await validateUser(user);

    if (!userExist.item1) {
      return Response(
        statusCode: HttpStatus.notFound,
        body: "This user doesn't exist",
      );
    }

    if (!BCrypt.checkpw(user.password!, userExist.item2!.password!)) {
      return Response(
        statusCode: HttpStatus.unauthorized,
        body: 'Your credentials are not allowed',
      );
    }

    final data = userExist.item2!.toJson()..remove('password');

    return Response.json(
      body: {
        'token': _jwtStrategy.sign(
          user,
        ),
        'user': data,
      },
    );
  }

  ///
  Future<Response> signUp(User user) async {
    final userExist = await validateUser(user);

    if (userExist.item1) {
      return Response(
        statusCode: HttpStatus.conflict,
        body: 'This user already exist',
      );
    }
    final userToCreated = user
      ..password = BCrypt.hashpw(
        user.password!,
        BCrypt.gensalt(),
      );

    final detaUser = await _detaService.save<User>(
      name: DetaName.users,
      data: userToCreated,
    );

    final data = detaUser.toJson()..remove('password');

    return Response.json(
      statusCode: HttpStatus.created,
      body: data,
    );
  }
}
