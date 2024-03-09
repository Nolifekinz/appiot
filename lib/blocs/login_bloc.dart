import 'package:appiot/events/login_event.dart';
import 'package:appiot/repositories/user_repository.dart';
import 'package:appiot/states/login_state.dart';
import 'package:appiot/validators/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;

  LoginBloc({required UserRepository userRepository}) :
      assert(userRepository != null),
      _userRepository = userRepository,
      super(LoginState.initial()) {
    on<LoginEvent>((loginEvent, emit) {
      final loginState = state;

      if(loginEvent is LoginEventEmailChanged) {
        emit(loginState.cloneAndUpdate(isValidEmail: Validators.isValidEmail(loginEvent.email)));
      } else if(loginEvent is LoginEventPasswordChanged) {
        emit(loginState.cloneAndUpdate(isValidPassword: Validators.isValidPassword(loginEvent.password)));
      }
    });

    on<LoginEventWithGooglePressed>((loginEvent, emit) async {
      try {
        await _userRepository.signInWithGoogle();
        emit(LoginState.success());
      } catch (_) {
        emit(LoginState.failure());
      }
    });

    on<LoginEventWithEmailAndPasswordPressed>((loginEvent, emit) async {
      try {
        await _userRepository.signInWithEmailAndPassword(loginEvent.email, loginEvent.password);
        emit(LoginState.success());
      } catch (_) {
        emit(LoginState.failure());
      }
    });
  }
}
