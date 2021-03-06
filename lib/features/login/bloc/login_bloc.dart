import 'dart:async';

import 'package:app/core/root_bloc/root_bloc.dart';
import 'package:app/shared/models/bloc_event.dart';
import 'package:app/shared/models/bloc_state.dart';
import 'package:app/shared/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final RootBloc rootBloc;
  final UserRepository userRepository;

  LoginBloc({
    this.rootBloc,
    this.userRepository,
  }) : super(LoginState.initial);

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginSubmit) {
      yield state.copyWith(
        submitting: true,
      );
      try {
        final authData = await userRepository.authenticate(
          email: event.email,
          password: event.password,
        );

        rootBloc.add(LoggedInEvent(authData));
      } catch (error) {} finally {
        yield state.copyWith(
          submitting: false,
        );
      }
    }
  }
}
