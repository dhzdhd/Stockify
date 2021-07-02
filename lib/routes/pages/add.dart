import 'dart:ui';

import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 64.0, sigmaY: 64.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white70.withOpacity(0.2)),
          child: Center(
            child: Text('e'),
          ),
        ),
      ),
    );
  }
}
