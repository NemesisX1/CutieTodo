import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cutie_todo_app/ui/auth/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());

  void setRegistrationMode() {
    return emit(
      AuthState()..isOnRegistration = !state.isOnRegistration,
    );
  }
}
