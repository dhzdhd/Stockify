import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:stockify/backend/store.dart';
import 'package:stockify/models/login_signup.dart';
import 'package:stockify/models/profile.dart';
import 'package:stockify/widgets/login_button.dart';

import '../widgets/login_field.dart';
import '../backend/auth.dart';

const String mobileLoginSvgPath = 'lib/assets/svg/mobile_login.svg';
const String desktopLoginSvgPath = 'lib/assets/svg/desktop_login.svg';

enum PopupOptions { forgotPassword }

SnackBar errorSnackBar({required String text}) {
  return SnackBar(
    content: Text(
      text,
      textAlign: TextAlign.center,
    ),
    duration: Duration(milliseconds: 1000),
  );
}

class LoginRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.of(context).size.width < 1200
          ? MobileLoginScreen()
          : DesktopLoginScreen(),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0),
            child: SvgPicture.asset(
              mobileLoginSvgPath,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(color: Colors.transparent),
          child: Column(
            children: [
              Flexible(flex: 4, child: SafeArea(child: WelcomeContainer())),
              Flexible(flex: 6, child: FieldContainer()),
              Flexible(flex: 2, child: SignUpContainer()),
            ],
          ),
        ),
      ],
    );
  }
}

class DesktopLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.blueAccent),
        child: Column(children: [
          Flexible(
              flex: 7,
              child: Container(
                child: Row(
                  children: [
                    Spacer(flex: 1),
                    Flexible(
                        flex: 2,
                        child: Column(
                          children: [
                            Spacer(flex: 3),
                            Flexible(flex: 3, child: WelcomeContainer()),
                            Spacer(flex: 5)
                          ],
                        )),
                    Spacer(flex: 1),
                    Flexible(flex: 3, child: DesktopHorizontalContainer()),
                    Spacer(flex: 1),
                  ],
                ),
              )),
          Flexible(
              child: Center(
            child: SignUpContainer(),
          ))
        ]));
  }
}

class DesktopHorizontalContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(),
      child: Column(
        children: [
          Spacer(flex: 4),
          Flexible(flex: 7, child: FieldContainer()),
          Spacer(flex: 5)
        ],
      ),
    );
  }
}

class WelcomeContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Spacer(flex: 5),
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Welcome!',
                  style: TextStyle(fontSize: 55, color: Colors.white),
                ),
              )),
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Consumer<LoginSignupModel>(
                      builder: (builder, model, child) {
                    return Text(
                      model.model
                          ? 'Log in to continue!'
                          : 'Sign in to continue!',
                      style: TextStyle(
                          fontSize: 35,
                          color: Color.fromARGB(255, 207, 212, 215)),
                    );
                  }))),
          Spacer(
            flex: 1,
          )
        ],
      ),
    );
  }
}

class FieldContainer extends StatefulWidget {
  @override
  FieldContainerState createState() => FieldContainerState();
}

class FieldContainerState extends State<FieldContainer> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  final RegExp regExp = RegExp("\\.com|@");

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void emailDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(
              'Email Signup',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Text(
                  'Check your email to confirm the sign up. Warning! you cannot login again if you do not confirm your email!',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed('/content');
                  },
                  child: Text('Understood!'),
                ),
              )
            ],
          );
        },
      );
    }

    Future loginConstraint() async {
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        if (emailController.text.contains(regExp)) {
          if (await Auth(
                  email: emailController.text,
                  password: passwordController.text,
                  context: context)
              .signIn()) {
            if (LoginSignupModel().switchValue == true) {
              if (!await LoginData().storeData(
                  email: emailController.text,
                  password: passwordController.text)) {
                ScaffoldMessenger.of(context).showSnackBar(
                    errorSnackBar(text: "Data could not be stored locally"));
              }
            }
            Navigator.of(context).popAndPushNamed('/content');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(
              text: "Username/password incorrectly entered!",
            ));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(
            text: "Enter a valid email address!",
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(
          text: "Field(s) cannot be empty!",
        ));
      }
    }

    Future signUpConstraint() async {
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          confirmController.text.isNotEmpty) {
        if (emailController.text.contains(regExp)) {
          if (passwordController.text == confirmController.text) {
            if (await Auth(
                    email: emailController.text,
                    password: passwordController.text,
                    context: context)
                .signUp()) {
              if (LoginSignupModel().switchValue == true) {
                if (!await LoginData().storeData(
                    email: emailController.text,
                    password: passwordController.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      errorSnackBar(text: "Data could not be stored locally"));
                }
              }
              emailDialog();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(
                text: "User already signed up!",
              ));
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(
              text: "Passwords don't match!",
            ));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(
            text: "Enter a valid email address!",
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(
          text: "Field(s) cannot be empty!",
        ));
      }
    }

    return Consumer<LoginSignupModel>(builder: (builder, model, child) {
      return Container(
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Spacer(
                    flex: 10,
                  ),
                  LoginField(
                    text: 'Username',
                    hidden: false,
                    controller: emailController,
                  ),
                  Spacer(),
                  LoginField(
                    text: 'Password',
                    hidden: true,
                    controller: passwordController,
                  ),
                  Spacer(),
                  Visibility(
                      visible: model.model ? false : true,
                      child: LoginField(
                        text: 'Confirm password',
                        hidden: true,
                        controller: confirmController,
                      )),
                  Spacer(
                    flex: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoginButton(
                        text: model.model ? 'Login' : 'Sign Up',
                        func: model.model
                            ? () async {
                                await loginConstraint();
                                // Navigator.of(context).popAndPushNamed('/content');
                              }
                            : () async {
                                await signUpConstraint();
                              },
                      ),
                      PopupMenuButton<PopupOptions>(
                        tooltip: 'Options',
                        onCanceled: null,
                        onSelected: (PopupOptions result) {
                          if (result == PopupOptions.forgotPassword) {
                            print('e');
                          }
                        },
                        color: Color.fromARGB(255, 51, 166, 175),
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            child: Consumer<LoginSignupModel>(
                              builder: (context, model, child) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Remember info'),
                                    Switch(
                                      activeColor:
                                          Color.fromARGB(255, 9, 59, 72),
                                      value: model.switchValue,
                                      onChanged: (foo) {
                                        model.changeSwitchValue(foo);
                                      },
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                          PopupMenuItem(
                            value: PopupOptions.forgotPassword,
                            child: Consumer<LoginSignupModel>(
                              builder: (context, model, child) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Text('Forgot password?')],
                                );
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Spacer(
                    flex: 7,
                  )
                ]),
          ),
        ),
      );
    });
  }
}

class SignUpContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Consumer<LoginSignupModel>(builder: (builder, model, child) {
          return TextButton(
            child: Text(
              model.model
                  ? 'Not signed in? Sign up here \u2794'
                  : 'Already signed in? Login here \u2794',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            onPressed: () => model.model ? model.toSignUp() : model.toLogin(),
          );
        }),
      ),
    );
  }
}
