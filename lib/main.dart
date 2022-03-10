// @dart=2.9
import 'package:flutter/material.dart';
import 'package:pinsmap/services/locator.dart';
import 'package:pinsmap/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pinsmap/services/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  
  await Firebase.initializeApp();
  setupLocator();
  runApp(App());
}
