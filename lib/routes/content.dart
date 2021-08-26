import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:stockify/backend/auth.dart';
import 'package:stockify/models/nav_bar.dart';
import 'package:stockify/utilities.dart';
import 'package:stockify/widgets/custom_button.dart';

import 'pages/home.dart';
import 'pages/settings.dart';
import 'pages/add.dart';

final _pages = [HomePage(), AddPage(), SettingsPage()];
const String mobileSvgPath = 'lib/assets/svg/mobile.svg';

class ContentRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width < 1200
        ? _MobileContentRoute()
        : _DesktopContentRoute();
  }
}

class _DesktopContentRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NavBarModel>(builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text(
                  'Menu',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home_outlined),
                title: Text('Home'),
                onTap: () => model.changePage(0),
              ),
              ListTile(
                leading: Icon(Icons.add_outlined),
                title: Text('Add'),
                onTap: () => model.changePage(1),
              ),
              ListTile(
                leading: Icon(Icons.settings_outlined),
                title: Text('Settings'),
                onTap: () => model.changePage(2),
              ),
            ],
          ),
        ),
        body: _pages[model.pageIndex],
      );
    });
  }
}

class _MobileContentRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget returnDialog(NavBarModel model) {
      return Utilities.blurify(
        child: SimpleDialog(
          backgroundColor: Colors.white.withOpacity(0.2),
          title: Center(
              child: Text(
            'Return to login screen?',
            style: TextStyle(color: Colors.white),
          )),
          children: [
            Padding(
              padding: EdgeInsets.only(left: 50, right: 50, top: 5),
              child: CustomButton(
                text: 'Yes',
                func: () async {
                  model.changePage(0);
                  if (await Auth.signOut())
                    Navigator.of(context).popAndPushNamed('/');
                },
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10),
              child: CustomButton(
                text: 'No',
                func: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      );
    }

    return Consumer<NavBarModel>(builder: (context, model, child) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        bottomNavigationBar: CurvedNavigationBar(
          animationDuration: Duration(milliseconds: 300),
          height: 55,
          backgroundColor: Colors.transparent,
          color: Color.fromARGB(155, 23, 103, 117),
          items: [
            Icon(Icons.home_outlined),
            Icon(Icons.add_outlined),
            Icon(Icons.settings_outlined)
          ],
          onTap: (index) => model.changePage(index),
        ),
        body: Stack(
          children: [
            SvgPicture.asset(
              mobileSvgPath,
              fit: BoxFit.cover,
            ),
            SafeArea(
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_sharp,
                          size: 30,
                        ),
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return returnDialog(model);
                              });
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 12,
                    child: _pages[model.pageIndex],
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
