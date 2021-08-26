import 'dart:ui';

import 'package:flutter/material.dart';

class Utilities {
  static Widget blurify({required Widget child}) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
        child: child,
      ),
    );
  }
}
