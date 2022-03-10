import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pinsmap/Constant.dart';
import 'package:pinsmap/services/auth.dart';
import 'package:pinsmap/src/components/HomeLayout.dart';
import 'package:pinsmap/src/pages/onboardPage.dart';
import 'package:pinsmap/src/pages/signInPage.dart';
import 'package:pinsmap/src/pages/signUpPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pinsmap/services/database.dart';
import 'package:pinsmap/services/locator.dart';
import 'package:pinsmap/services/dynamic_links.dart';

class Splash extends StatefulWidget {
  static String id = "Splash";
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // final DynamicLinkService _dynamicLinkService = DynamicLinkService();

  final AuthService _auth = AuthService();

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool value = pref.containsKey('key');

    // if (value == true) {
    print(_auth.CurrentUser());
    if (await _auth.CurrentUser() == null) {      
      // send the user to the home page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return OnboardPage();
          },
        ),
        (r) => false,
      );
    } else {           
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return HomeLayout();
          },
        ),
        (r) => false,
      );      
    }
  }

  void initState() {
    super.initState();
    // _dynamicLinkService.handleDynamicLinks();    
    startTime();    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromRGBO(88, 87, 194, 1),
          body: Center(
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          )),
    );
  }
}
