import 'package:cutie_todo_app/ui/auth/cubit/auth_cubit.dart';
import 'package:cutie_todo_app/ui/auth/cubit/auth_state.dart';
import 'package:cutie_todo_app/ui/todo/cubit/todo.cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: const AuthView(),
    );
  }
}

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - kToolbarHeight,
                constraints: kIsWeb
                    ? BoxConstraints(
                        maxWidth: constraints.maxWidth > 600
                            ? 500
                            : MediaQuery.of(context).size.width,
                      )
                    : null,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/cutietodo_white.png',
                      color: Colors.pink.shade400,
                    ),
                    const Gap(40),
                    Text(
                      context.watch<AuthCubit>().state.isOnRegistration
                          ? 'Register'
                          : 'Login',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    const Gap(20),
                    TextFormField(
                      cursorColor: Colors.pink.shade400,
                      controller:
                          context.read<AuthCubit>().state.usernameController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      obscureText: true,
                      decoration: InputDecoration(
                        focusColor: Colors.pink.shade400,
                        hintText: 'Your username',
                        hintStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.pink.shade400,
                            width: 2,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.pink.shade400,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const Gap(20),
                    TextFormField(
                      cursorColor: Colors.pink.shade400,
                      controller:
                          context.read<AuthCubit>().state.passwordController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        focusColor: Colors.pink.shade400,
                        hintText: 'Your password',
                        hintStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.pink.shade400,
                            width: 2,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.pink.shade400,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const Gap(30),
                    Align(
                      child: TextButton(
                        onPressed:
                            context.read<AuthCubit>().setRegistrationMode,
                        child: Text(
                          context.watch<AuthCubit>().state.isOnRegistration
                              ? 'Do you want to login instead ?'
                              : 'Do yo want to register instead ?',
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size.fromWidth(
                          MediaQuery.of(context).size.width,
                        ),
                      ),
                      child: Text(
                        context.watch<AuthCubit>().state.isOnRegistration
                            ? 'Sign Up'
                            : 'Sign In',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Gap(20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
