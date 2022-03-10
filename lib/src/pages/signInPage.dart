import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pinsmap/services/auth_result_exception.dart';
import 'package:pinsmap/src/components/HomeLayout.dart';
import 'package:pinsmap/src/pages/signUpPage.dart';
import 'package:pinsmap/services/auth.dart';
import 'package:pinsmap/services/google_signIn.dart';
import 'package:pinsmap/services/locator.dart';
import 'package:pinsmap/services/analytics.dart';
import 'package:pinsmap/services/facebookLogin.dart';
import 'package:pinsmap/services/admob.dart';
import 'package:firebase_admob/firebase_admob.dart';

class SignInPage extends StatelessWidget {
  final GoogleSignInProvider _provider = GoogleSignInProvider();
  final facebook_login _facebookLogin = facebook_login();
  final AuthService _auth = AuthService();
  final AnalyticsService _analyticsService = locator<AnalyticsService>();

  adMob _ad = adMob();
  String email = '';
  String password = '';
  dynamic error;

  void displayToast(dynamic result, BuildContext context,
      {bool isSuccess = false}) {
    if (!isSuccess) {
      error = AuthExceptionHandler.generateExceptionMessage(result);
    }
    // Toast.show(
    //   isSuccess ? 'Successfully Log In' : error,
    //   context,
    //   duration: 3,
    // );
    Fluttertoast.showToast(
      msg: isSuccess ? 'Successfully Log In' : error,
    
    );
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-5741002225942405~5953238132")
        .then((response) {
      _ad.myBanner
        ..load()
        ..show();
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            Container(
              // color: Colors.amber,
              child: Image.asset(
                'assets/logo2.png',
                height: 170,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              'Sign In',
              style: Theme.of(context).textTheme.headline6!.merge(TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  )),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    child: TextField(
                      onChanged: (v) {
                        email = v;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .caption!
                            .merge(TextStyle(fontSize: 12)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff5857C2),
                            width: 0.5,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff5857C2),
                            width: 0.5,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff5857C2),
                            width: 0.5,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 50,
                    child: TextField(
                      onChanged: (v) {
                        password = v;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.visibility_off_outlined,
                          size: 20,
                        ),
                        hintText: 'Password',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .caption!
                            .merge(TextStyle(fontSize: 12)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff5857C2),
                            width: 0.5,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff5857C2),
                            width: 0.5,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff5857C2),
                            width: 0.5,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 18,
                        width: 18,
                        child: Checkbox(value: true, onChanged: (v) {}),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Remember me',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .merge(TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.grey,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 45,
                    width: Get.width,
                    decoration: BoxDecoration(),
                    child: MaterialButton(
                      onPressed: () async {
                        if (password != null && password != "") {
                          dynamic result = await _auth
                              .signInwithEmailandPassword(email, password);
                          if (result == null) {
                            print("Somthing Wrong");
                          } else if (result == AuthResultStatus.userNotFound) {
                            displayToast(result, context);
                          } else if (result == AuthResultStatus.invalidEmail) {
                            displayToast(result, context);
                          } else if (result == AuthResultStatus.wrongPassword) {
                            displayToast(result, context);
                          } else if (result == AuthResultStatus.userDisabled) {
                            displayToast(result, context);
                          } else if (result ==
                              AuthResultStatus.tooManyRequests) {
                            displayToast(result, context);
                          } else if (result ==
                              AuthResultStatus.operationNotAllowed) {
                            displayToast(result, context);
                          } else {
                            await _analyticsService.logLogin();
                            Get.offAll(HomeLayout());
                          }
                        } else {
                          // Toast.show(
                          //   "Please Enter the Password",
                          //   context,
                          //   duration: 3,
                          // );

                          Fluttertoast.showToast(
                            msg: "Please Enter the Password",
                            // fontSize: 18,
                      
                          );
                        }
                      },
                      elevation: 0,
                      child: Text(
                        'Sign In',
                        style: Theme.of(context).textTheme.subtitle2!.merge(
                              TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                      ),
                      color: Color(0xff5857C2),
                      // minWidth: Get.width,
                      padding: EdgeInsets.symmetric(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.grey[350],
                    height: 1,
                    width: 150,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Or',
                    style:
                        Theme.of(context).textTheme.subtitle1!.merge(TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            )),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    child: Container(
                      color: Colors.grey[350],
                      height: 1,
                      width: 150,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    backgroundColor: HexColor('#db4a39'),
                    child: IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.google,
                        size: 20,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        dynamic result = await _provider.GoogleSignUp();
                        print(result);
                        if (result == null) {
                          print("Somthing Wrong");
                        } else {
                          Get.offAll(HomeLayout());
                        }
                      },
                    ),
                  ),
                  // CircleAvatar(
                  //   backgroundColor: Colors.black,
                  //   child: IconButton(
                  //     padding: EdgeInsets.symmetric(vertical: 0),
                  //     icon: FaIcon(
                  //       FontAwesomeIcons.apple,
                  //       size: 24,
                  //       color: Colors.white,
                  //     ),
                  //     onPressed: () {},
                  //   ),
                  // ),
                  CircleAvatar(
                    backgroundColor: HexColor('#4267B2'),
                    child: IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.facebookF,
                        size: 21,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        dynamic result =
                            await _facebookLogin.signInWithFacebook();
                        print(result);
                        if (result == null) {
                          print("Somthing Wrong");
                        } else {
                          Get.offAll(HomeLayout());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 70,
            ),
           
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account?'),
                Container(
                  height: 20,
                  child: TextButton(
                    onPressed: () {
                      Get.to(() => SignUpPage());
                    },
                    child: Text('Sign Up'),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                      ),
                    ),
                  ),
                )
              ],
            ),
         SizedBox(
               height:70,
            ),
          ],
        ),
      ),
    );
  }
}
