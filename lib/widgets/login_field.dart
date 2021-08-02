import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LoginField extends StatefulWidget {
  final String text;
  final bool hidden;
  final TextEditingController controller;

  LoginField(
      {required this.text, required this.hidden, required this.controller});

  @override
  LoginState createState() =>
      LoginState(text: text, hidden: hidden, controller: controller);
}

class LoginState extends State<LoginField> {
  final String text;
  final bool hidden;
  final TextEditingController controller;

  LoginState(
      {required this.text, required this.hidden, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Field(s) can't be empty!!";
        }
        if ([" "].contains(value)) {
          return "No spaces allowed!";
        }
        return null;
      },
    );
  }
}
