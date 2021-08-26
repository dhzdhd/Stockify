import 'dart:ui';

import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final model;

  CustomDialog(this.title, this.model);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            child: Column(
              children: [
                Text(
                  title,
                ),
                Row(
                  children: [
                    ElevatedButton(onPressed: () => null, child: Text('Ok')),
                    ElevatedButton(
                        onPressed: () => null, child: Text('Cancel')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
