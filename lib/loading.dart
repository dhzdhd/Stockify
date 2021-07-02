import 'package:flutter/material.dart';
import 'package:stockify/routes/login.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  final snapshot;

  Loading(this.snapshot);

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Center(
            child: SpinKitFadingCircle(
              color: Colors.blueAccent,
              duration: Duration(seconds: 20),
            ),
          ),
        ),
      )
    );
  }
}