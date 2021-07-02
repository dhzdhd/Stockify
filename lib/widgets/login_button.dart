import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final Function func;

  LoginButton(this.text, this.func);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shadowColor: Colors.black,
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        width: 200,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => this.func(),
          child: Container(
              child: Center(
            child: Text(
              this.text,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
        ),
      ),
    );
  }
}
