import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  final String text;
  final bool hidden;

  LoginField({required this.text, required this.hidden});

  final errorSnackBar = SnackBar(
    content: Text(
      'Field cannot be empty!',
      textAlign: TextAlign.center,
    ),
    duration: Duration(milliseconds: 700),
  );

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.white, //change with model
      obscureText: hidden,
      autocorrect: false,
      style: TextStyle(color: Color.fromARGB(255, 248, 248, 248)),
      decoration: InputDecoration(
        hintText: text,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      onSubmitted: (text) => text.isEmpty
          ? ScaffoldMessenger.of(context).showSnackBar(errorSnackBar)
          : null,
    );
  }
}
