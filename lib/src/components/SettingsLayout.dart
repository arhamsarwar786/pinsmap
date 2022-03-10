import 'package:flutter/material.dart';
import 'package:pinsmap/src/components/DrawerWidget.dart';

import 'package:pinsmap/src/pages/settingsPage.dart';

class SettingsLayout extends StatefulWidget {
  @override
  _SettingsLayoutState createState() => _SettingsLayoutState();
}

class _SettingsLayoutState extends State<SettingsLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerWidget(),
          SettingsPage(),
        ],
      ),
    );
  }
}
