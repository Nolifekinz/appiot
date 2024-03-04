import 'package:appiot/blocs/login_bloc.dart';
import 'package:appiot/events/login_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 45,
      child: ElevatedButton.icon(
        onPressed: () {
          BlocProvider.of<LoginBloc>(context).add(LoginEventWithGooglePressed());
          // Now test on a real device!
        },
        icon: Icon(
          FontAwesomeIcons.google,
          color: Colors.white,
          size: 17,
        ),
        label: Text(
          'Sign in with Google',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.redAccent,
        ),
      ),
    );
  }
}
