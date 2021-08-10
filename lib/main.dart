import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stockify/backend/store.dart';
import 'package:stockify/constants.dart';
import 'package:stockify/error.dart';
import 'package:stockify/loading.dart';
import 'package:stockify/models/login_signup.dart';
import 'package:stockify/models/nav_bar.dart';
import 'package:stockify/models/profile.dart';
import 'package:stockify/models/theme.dart';
import 'package:stockify/routes/forgot_password.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'routes/login.dart';
import 'routes/content.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'lib/.env');

  Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
    authCallbackUrlHostname: 'login-callback',
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => LoginSignupModel()),
          ChangeNotifierProvider(create: (context) => ThemeModel()),
          ChangeNotifierProvider(create: (context) => NavBarModel()),
          ChangeNotifierProvider(create: (context) => ProfileModel()),
        ],
        child: Consumer<ThemeModel>(builder: (builder, model, child) {
          return FutureBuilder(
              future: Future.wait([
                Connectivity().checkConnectivity(),
                LoginData().fetchData()
              ]),
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
                        '/content': (context) => ContentRoute(),
                        '/forgotPassword': (context) => ForgotPasswordRoute(),
                      });
                }
                return Loading(snapshot);
              });
        }));
  }
}
