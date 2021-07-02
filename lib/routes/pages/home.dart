import 'package:flutter/material.dart';
import 'package:stockify/widgets/tabs.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          CustomTab(onPress: () => print(''), title: 'Hello!'),
          CustomTab(onPress: () => print(''), title: 'Hello!'),
          CustomTab(onPress: () => print(''), title: 'Hello!'),
          CustomTab(onPress: () => print(''), title: 'Hello!'),
          CustomTab(onPress: () => print(''), title: 'Hello!'),
          CustomTab(onPress: () => print(''), title: 'Hello!'),
          CustomTab(onPress: () => print(''), title: 'Hello!'),
        ],
      ),
    );
  }
}
