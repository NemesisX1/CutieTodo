import 'dart:io';

import 'package:crypt/crypt.dart';
import 'package:dart_deta_frog_todo_server/controllers/base.controller.dart';
import 'package:dart_deta_frog_todo_server/helpers/enums.dart';
import 'package:dart_deta_frog_todo_server/helpers/globals.dart';
import 'package:dart_deta_frog_todo_server/models/user.model.dart';
import 'package:dart_deta_frog_todo_server/services/deta.service.dart';
import 'package:dart_deta_frog_todo_server/strategies/jwt_auth.strategy.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:deta/deta.dart';
import 'package:tuple/tuple.dart';
import 'package:uuid/uuid.dart';

///
class AuthController extends BaseController {
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

    if (Crypt(user.password!).match(userExist.item2!.password!)) {
      return Response(
        statusCode: HttpStatus.unauthorized,
        body: 'Your credentials are not allowed',
      );
    }

    return Response.json(
      body: {
        'token': _jwtStrategy.sign(
          user,
        ),
        'user': userExist.item2!.toJson().remove('password'),
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
    final userToCreated = user..password = Crypt.sha256(user.password!).salt;

    final detaUser = await _detaService.save<User>(
      name: DetaName.users,
      data: userToCreated,
    );

    return Response.json(
      statusCode: HttpStatus.created,
      body: detaUser.toJson().remove('password'),
    );
  }
}
