import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stockify/backend/auth.dart';
import 'package:stockify/constants.dart';
import 'package:stockify/routes/login.dart';
import 'package:stockify/widgets/login_button.dart';
import 'package:stockify/widgets/login_field.dart';

const String mobileLoginSvgPath = 'lib/assets/svg/mobile_login.svg';

/// FIXME:
class ForgotPasswordRoute extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  Widget build(BuildContext context) {
    Future updateConstraint() async {
      String password = _passwordController.text;
      String confirm = _confirmController.text;

      if (confirm.isNotEmpty && password.isNotEmpty) {
        if (password == confirm) {
          await Auth.forgotPassword(password);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(
            text: "Password and confirm password fields are not the same!",
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(
          text: "Field(s) cannot be empty!",
        ));
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            mobileLoginSvgPath,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Container(
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: 30,
                        ),
                        onPressed: () =>
                            Navigator.popAndPushNamed(context, '/'),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 12,
                    child: Container(
                      child: Column(
                        children: [
                          Spacer(flex: 6),
                          Text(
                            'Reset your password: ',
                            style: TextStyle(fontSize: 23),
                          ),
                          Padding(
                              padding:
                                  EdgeInsets.only(top: 60, left: 10, right: 10),
                              child: LoginField(
                                text: 'New password',
                                hidden: false,
                                controller: _passwordController,
                              )),
                          Padding(
                              padding:
                                  EdgeInsets.only(top: 20, left: 10, right: 10),
                              child: LoginField(
                                text: 'Confirm password',
                                hidden: false,
                                controller: _confirmController,
                              )),
                          Padding(
                              padding: EdgeInsets.only(top: 60),
                              child: LoginButton(
                                  text: 'Update',
                                  func: () async {
                                    updateConstraint();
                                  })),
                          Spacer(flex: 9),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
