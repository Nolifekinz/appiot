import 'package:appiot/events/register_event.dart';
import 'package:appiot/repositories/user_repository.dart';
import 'package:appiot/states/register_state.dart';
import 'package:appiot/validators/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(RegisterState.initial()) {
    on<RegisterEvent>((event, emit) {
      if (event is RegisterEventEmailChanged) {
        emit(state.cloneAndUpdate(
          isValidEmail: Validators.isValidEmail(event.email),
        ));
      } else if (event is RegisterEventPasswordChanged) {
        emit(state.cloneAndUpdate(
          isValidPassword: Validators.isValidPassword(event.password),
        ));
      }
    });

    on<RegisterEventPressed>((event, emit) async {
      emit(RegisterState.loading());
      try {
        await _userRepository.createUserWithEmailAndPassword(
          event.email,
          event.password,
        );
        emit(RegisterState.success());
      } catch (_) {
        emit(RegisterState.failure());
      }
    });
  }

  @override
  Stream<Transition<RegisterEvent, RegisterState>> transformTransitions(
    Stream<Transition<RegisterEvent, RegisterState>> transitions,
  ) {
    final debounceStream = transitions.where((transition) {
      return (transition.event is RegisterEventEmailChanged ||
          transition.event is RegisterEventPasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));

    final nonDebounceStream = transitions.where((transition) {
      return (transition.event is! RegisterEventEmailChanged &&
          transition.event is! RegisterEventPasswordChanged);
    });

    return nonDebounceStream.mergeWith([debounceStream]);
  }
}
