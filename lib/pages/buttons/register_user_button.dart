import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:appiot/blocs/register_bloc.dart';
import 'package:appiot/repositories/user_repository.dart';
import '../register_page.dart';

class RegisterUserButton extends StatelessWidget {
  final UserRepository userRepository;

  const RegisterUserButton({
    Key? key,
    required this.userRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 45,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: Colors.green,
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return BlocProvider<RegisterBloc>(
                create: (context) =>
                    RegisterBloc(userRepository: userRepository),
                child: RegisterPage(userRepository: userRepository),
              );
            }),
          );
        },
        child: Text(
          'Register',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
