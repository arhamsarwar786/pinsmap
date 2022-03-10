import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pinsmap/services/locator.dart';
import 'package:pinsmap/src/pages/welcomePage.dart';
import 'pages/SplashScreen.dart';
import 'package:pinsmap/services/analytics.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      smartManagement: SmartManagement.onlyBuilder,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: [locator<AnalyticsService>().getAnalyticsObserver()],
      home: Splash(),
      
    );
  }
}
