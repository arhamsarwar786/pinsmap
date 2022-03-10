import 'package:flutter/material.dart';
import 'package:pinsmap/src/components/DrawerWidget.dart';

import 'package:pinsmap/src/pages/welcomePage.dart';

class WelcomeLayout extends StatefulWidget {
  @override
  _WelcomeLayoutState createState() => _WelcomeLayoutState();
}

class _WelcomeLayoutState extends State<WelcomeLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerWidget(),
          WelcomePage(),
        ],
      ),
    );
  }
}
