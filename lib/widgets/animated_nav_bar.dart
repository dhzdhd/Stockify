import 'package:flutter/material.dart';

class AnimatedNavBar extends StatefulWidget {
  final animationDuration;
  final height;
  final backgroundColor;
  final color;
  final items;
  final onTap;

  AnimatedNavBar(
      {required this.animationDuration,
      this.height,
      this.backgroundColor,
      this.color,
      this.items,
      this.onTap});

  @override
  _AnimatedNavBarState createState() => _AnimatedNavBarState();
}

class _AnimatedNavBarState extends State<AnimatedNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      height: widget.height,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[],
      ),
    );
  }
}
