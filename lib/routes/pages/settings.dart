import 'dart:ui';

import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final titleTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  final textStyle = TextStyle(color: Colors.black);

  SettingsPage();

  @override
  Widget build(BuildContext context) {
    void profileDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Text(
                'Profile',
                style: titleTextStyle,
              ),
            ),
            children: [
              ListTile(
                title: Text('Username', style: textStyle),
                subtitle: Text(
                  'eee',
                  style: textStyle,
                ),
              ),
              Divider(),
              ListTile(),
            ],
          );
        },
      );
    }

    void themeDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(
              'Themes',
              style: titleTextStyle,
            ),
            children: [
              SimpleDialogOption(
                onPressed: () => print(''),
                child: Text('Blue'),
              ),
              SimpleDialogOption(
                onPressed: () => print(''),
                child: Text('Dark'),
              ),
            ],
          );
        },
      );
    }

    void helpDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(
              'Help',
              style: titleTextStyle,
            ),
            children: [
              Text('About developer: \nContact: dhzdhd#2244 on discord')
            ],
          );
        },
      );
    }

    return Container(
      child: ListView(
        children: [
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.white,
            ),
            title: Text('Profile'),
            onTap: () => profileDialog(),
          ),
          ListTile(
            leading: Icon(
              Icons.palette,
              color: Colors.white,
            ),
            title: Text('Theme'),
            onTap: () => themeDialog(),
          ),
          ListTile(
            leading: Icon(
              Icons.help,
              color: Colors.white,
            ),
            title: Text('Help'),
            onTap: () => helpDialog(),
          ),
        ],
      ),
    );
  }
}
