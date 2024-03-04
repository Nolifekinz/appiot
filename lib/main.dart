import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:appiot/repositories/user_repository.dart';

import 'package:appiot/blocs/authentication_bloc.dart';
import 'package:appiot/blocs/login_bloc.dart';
import 'package:appiot/blocs/simple_bloc_observer.dart';
import 'package:appiot/events/authentication_event.dart';
import 'package:appiot/pages/login_page.dart';
import 'package:appiot/pages/splash_page.dart';
import 'package:appiot/states/authentication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/pages/home_page.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserRepository _userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login with Firebase',
      home: BlocProvider(
        create: (context) => AuthenticationBloc(userRepository: _userRepository)
          ..add(AuthenticationEventStarted()),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, authenticationState) {
            if (authenticationState is AuthenticationStateSuccess) {
              return MyHomePage();
            } else if (authenticationState is AuthenticationStateFailure) {
              return BlocProvider<LoginBloc>(
                create: (context) => LoginBloc(userRepository: _userRepository),
                child: LoginPage(userRepository: _userRepository),
              );
            }
            return SplashPage();
          },
        ),
      ),
    );
  }
}
