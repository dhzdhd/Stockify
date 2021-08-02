import 'package:flutter/material.dart';

final darkTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: 'Montserrat',
);
final blueTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'Montserrat',
  fontSize: 18,
);

class ThemeModel extends ChangeNotifier {
  ThemeData theme = blueTheme;

  static final darkTheme = ThemeData(
      textTheme: TextTheme(
          headline1: darkTextStyle,
          headline2: darkTextStyle,
          headline3: darkTextStyle,
          headline4: darkTextStyle,
          headline5: darkTextStyle,
          headline6: darkTextStyle,
          button: darkTextStyle,
          subtitle1: darkTextStyle,
          subtitle2: darkTextStyle,
          bodyText1: darkTextStyle,
          bodyText2: darkTextStyle,
          overline: darkTextStyle),
      fontFamily: 'Montserrat',
      scaffoldBackgroundColor: Colors.black45);

  static final blueTheme = ThemeData(
    textTheme: TextTheme(
      headline1: blueTextStyle,
      headline2: blueTextStyle,
      headline3: blueTextStyle,
      headline4: blueTextStyle,
      headline5: blueTextStyle,
      headline6: blueTextStyle,
      button: blueTextStyle,
      subtitle1: blueTextStyle,
      subtitle2: blueTextStyle,
      bodyText1: blueTextStyle,
      bodyText2: blueTextStyle,
      overline: blueTextStyle,
    ),
    appBarTheme: AppBarTheme(color: Color.fromARGB(0, 0, 0, 0)),
    iconTheme: IconThemeData(size: 30, color: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      primary: Colors.blueAccent,
      textStyle: TextStyle(color: Colors.white),
    )),
    fontFamily: 'Montserrat',
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.redAccent,
      actionTextColor: Colors.white,
      elevation: 5.0,
    ),
  );

  void changeTheme(String choice) {
    switch (choice) {
      case 'dark':
        {
          theme = darkTheme;
          break;
        }
      case 'blue':
        {
          theme = blueTheme;
          break;
        }
    }
    notifyListeners();
  }
}
