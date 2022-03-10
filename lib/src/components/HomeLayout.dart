import 'package:flutter/material.dart';
import 'package:pinsmap/src/components/DrawerWidget.dart';
import 'package:pinsmap/src/pages/homePage.dart';
import 'package:pinsmap/src/pages/welcomePage.dart';

class HomeLayout extends StatefulWidget {
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerWidget(),
          HomePage(),
          // WelcomePage(),
        ],
      ),
    );
  }
}
