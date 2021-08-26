import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockify/models/profile.dart';
import 'package:stockify/utilities.dart';

final _titleTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
final _subTextStyle = TextStyle(color: Colors.white54);

class SettingsPage extends StatelessWidget {
  final themeDialog = SimpleDialog(
    backgroundColor: Colors.white.withOpacity(0.2),
    title: Text(
      'Themes',
      style: _titleTextStyle,
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

  final helpDialog = SimpleDialog(
    backgroundColor: Colors.white.withOpacity(0.2),
    title: Text(
      'Help',
      style: _titleTextStyle,
    ),
    children: [
      ListTile(
        title: Padding(
          padding: EdgeInsets.only(right: 10, left: 10),
          child: Text(
            'About developer: \nContact: dhzdhd#2244 on discord',
          ),
        ),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    void profileDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Consumer<ProfileModel>(builder: (context, model, child) {
            return Utilities.blurify(
              child: SimpleDialog(
                backgroundColor: Colors.white.withOpacity(0.2),
                title: Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Text(
                    'Profile',
                    style: _titleTextStyle,
                  ),
                ),
                children: [
                  ListTile(
                    title: Text('Email: '),
                    subtitle: Text(
                      model.profileUser?.email ?? 'Error',
                      style: _subTextStyle,
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('ID: '),
                    subtitle: Text(
                      model.profileUser?.id ?? 'Error',
                      style: _subTextStyle,
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Created on: '),
                    subtitle: Text(
                      model.profileUser?.createdAt.substring(0, 10) ?? 'Error',
                      style: _subTextStyle,
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Last signed in on: '),
                    subtitle: Text(
                      model.profileUser?.lastSignInAt?.substring(0, 10) ??
                          'Error',
                      style: _subTextStyle,
                    ),
                  ),
                ],
              ),
            );
          });
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
              onTap: () => profileDialog()),
          ListTile(
            leading: Icon(
              Icons.palette,
              color: Colors.white,
            ),
            title: Text('Theme'),
            onTap: () => {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Utilities.blurify(child: themeDialog);
                },
              )
            },
          ),
          ListTile(
            leading: Icon(
              Icons.help,
              color: Colors.white,
            ),
            title: Text('Help'),
            onTap: () => {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Utilities.blurify(child: helpDialog);
                },
              )
            },
          ),
        ],
      ),
    );
  }
}
