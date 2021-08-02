import 'package:flutter/material.dart';

class SomethingWentWrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Container(
        child: Center(
          child: Text(
            'The authentication server could not be initialised!\nPlease check your internet connection.',
            style: TextStyle(fontSize: 50),
          ),
        ),
      ),
    ));
  }
}
