import 'package:cutie_todo_app/l10n/l10n.dart';
import 'package:cutie_todo_app/routes.dart';
import 'package:cutie_todo_app/ui/auth/cubit/auth_cubit.dart';
import 'package:cutie_todo_app/ui/auth/views/auth_page.dart';
import 'package:cutie_todo_app/ui/counter/view/counter_page.dart';
import 'package:cutie_todo_app/ui/todo/cubit/todo.cubit.dart';
import 'package:cutie_todo_app/ui/todo/view/todo.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoCubit>(
          create: (BuildContext context) => TodoCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit(),
        )
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            color: Colors.black,
            elevation: 0,
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: Colors.pink.shade400,
          ),
          timePickerTheme: TimePickerThemeData(
            dayPeriodTextColor: Colors.pink.shade400,
            entryModeIconColor: Colors.pink.shade400,
            dialHandColor: Colors.pink.shade400,
            hourMinuteColor: Colors.pink.shade400,
            hourMinuteTextColor: Colors.white,
            helpTextStyle: TextStyle(
              color: Colors.pink.shade400,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.pink.shade400,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink.shade600,
              fixedSize: const Size.fromWidth(1000),
              padding: const EdgeInsets.all(20),
              textStyle: const TextStyle(fontSize: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    );
  }
}
