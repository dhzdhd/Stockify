import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockify/models/profile.dart';

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
          return Consumer<ProfileModel>(builder: (context, model, child) {
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
                  title: Text('Email: ', style: textStyle),
                  subtitle: Text(model.profileUser?.email ?? 'Error',
                      style: textStyle),
                ),
                Divider(),
                ListTile(
                  title: Text('ID: ', style: textStyle),
                  subtitle: Text(
                    model.profileUser?.id ?? 'Error',
                    style: textStyle,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('Created on: ', style: textStyle),
                  subtitle: Text(
                    model.profileUser?.createdAt.substring(0, 10) ?? 'Error',
                    style: textStyle,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('Last signed in on: ', style: textStyle),
                  subtitle: Text(
                    model.profileUser?.lastSignInAt?.substring(0, 10) ?? 'None',
                    style: textStyle,
                  ),
                ),
              ],
            );
          });
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
              Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: Text(
                  'About developer: \nContact: dhzdhd#2244 on discord',
                  style: textStyle,
                ),
              )
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
