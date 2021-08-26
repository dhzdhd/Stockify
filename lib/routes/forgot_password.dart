import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stockify/backend/auth.dart';
import 'package:stockify/constants.dart';
import 'package:stockify/routes/login.dart';
import 'package:stockify/utilities.dart';
import 'package:stockify/widgets/custom_button.dart';
import 'package:stockify/widgets/login_field.dart';

const String mobileLoginSvgPath = 'lib/assets/svg/mobile_login.svg';

class ForgotPasswordRoute extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final checkDialog = Utilities.blurify(
    child: AlertDialog(
        title: Text(
      'Check your email for password reset instructions!',
      style: TextStyle(color: Colors.black),
    )),
  );

  Widget build(BuildContext context) {
    Future updateConstraint() async {
      String email = _emailController.text;
      final RegExp regExp = RegExp("\\.com|@");

      if (email.isNotEmpty) {
        if (email.contains(regExp)) {
          if (await Auth.forgotPassword(email)) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return checkDialog;
                });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(
              text: "Failed to reset password!",
            ));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(
            text: "Not a valid email!",
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(
          text: "Field cannot be empty!",
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
                                text: 'Email',
                                hidden: false,
                                controller: _emailController,
                              )),
                          Padding(
                              padding: EdgeInsets.only(top: 60),
                              child: CustomButton(
                                  text: 'Reset',
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
