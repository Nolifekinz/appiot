import 'package:appiot/events/authentication_event.dart';
import 'package:appiot/repositories/user_repository.dart';
import 'package:appiot/states/authentication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({required UserRepository userRepository}) :
      assert(userRepository != null),
      _userRepository = userRepository,
      super(AuthenticationStateInitial()) {
    on<AuthenticationEventStarted>(_onAuthenticationStarted);
    on<AuthenticationEventLoggedIn>(_onAuthenticationLoggedIn);
    on<AuthenticationEventLoggedOut>(_onAuthenticationLoggedOut);
  }

  void _onAuthenticationStarted(AuthenticationEventStarted event, Emitter<AuthenticationState> emit) async {
    try {
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        final firebaseUser = await _userRepository.getUser();
        if (firebaseUser != null) {
          emit(AuthenticationStateSuccess(firebaseUser: firebaseUser));
        } else {
          emit(AuthenticationStateFailure());
        }
      } else {
        emit(AuthenticationStateFailure());
      }
    } catch (e) {
      emit(AuthenticationStateFailure());
    }
  }

  void _onAuthenticationLoggedIn(AuthenticationEventLoggedIn event, Emitter<AuthenticationState> emit) async {
    try {
      final firebaseUser = await _userRepository.getUser();
      if (firebaseUser != null) {
        emit(AuthenticationStateSuccess(firebaseUser: firebaseUser));
      } else {
        emit(AuthenticationStateFailure());
      }
    } catch (e) {
      emit(AuthenticationStateFailure());
    }
  }

  void _onAuthenticationLoggedOut(AuthenticationEventLoggedOut event, Emitter<AuthenticationState> emit) async {
    try {
      await _userRepository.signOut();
      emit(AuthenticationStateFailure());
    } catch (e) {
      emit(AuthenticationStateFailure());
    }
  }

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent authenticationEvent) async* {
    // Không cần xử lý sự kiện AuthenticationEventLoggedIn ở đây vì đã được xử lý trong _onAuthenticationLoggedIn
  }
}
