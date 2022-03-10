import 'package:flutter/material.dart';
import 'package:pinsmap/src/components/DrawerWidget.dart';
import 'package:pinsmap/src/pages/aboutPage.dart';

class AboutLayout extends StatefulWidget {
  @override
  _AboutLayoutState createState() => _AboutLayoutState();
}

class _AboutLayoutState extends State<AboutLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerWidget(),
          AboutPage(),
        ],
      ),
    );
  }
}
