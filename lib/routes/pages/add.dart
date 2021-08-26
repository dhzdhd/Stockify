import 'package:flutter/material.dart';
import 'package:stockify/widgets/custom_button.dart';

class AddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Flexible(flex: 10, child: MainContainer()),
          Flexible(flex: 1, child: ButtonContainer()),
          Spacer(),
        ],
      ),
    );
  }
}

class MainContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ButtonContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomButton(
        text: 'Add',
        func: () => null,
      ),
    );
  }
}
