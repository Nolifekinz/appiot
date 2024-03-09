import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RegisterButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: Colors.green,
        ),
        onPressed: () {
          onPressed?.call();
          // Navigate back
          Navigator.of(context).pop();
        },
        child: Text(
          'Register',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
