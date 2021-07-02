import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockify/error.dart';
import 'package:stockify/loading.dart';
import 'package:stockify/models/login_signup.dart';
import 'package:stockify/models/nav_bar.dart';
import 'package:stockify/models/theme.dart';

import 'routes/login.dart';
import 'routes/content.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MyApp> {
  final Future<FirebaseApp> _init = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => LoginSignupModel()),
          ChangeNotifierProvider(create: (context) => ThemeModel()),
          ChangeNotifierProvider(create: (context) => NavBarModel())
        ],
        child: Consumer<ThemeModel>(builder: (builder, model, child) {
          return FutureBuilder(
              future: _init,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  print(snapshot.data);
                  return SomethingWentWrong();
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: 'Stockify',
                      theme: model.theme,
                      initialRoute: '/',
                      routes: <String, Widget Function(BuildContext)>{
                        '/': (context) => LoginRoute(),
                        '/content': (context) => ContentRoute()
                      });
                }
                return Loading(snapshot);
              });
        }));
  }
}
