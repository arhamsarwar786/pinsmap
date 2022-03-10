import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pinsmap/services/auth.dart';
import 'package:pinsmap/services/auth_result_exception.dart';
import 'package:pinsmap/src/pages/signInPage.dart';
import 'package:pinsmap/services/google_signIn.dart';
import 'package:pinsmap/src/components/HomeLayout.dart';
import 'package:pinsmap/services/analytics.dart';
import 'package:pinsmap/services/locator.dart';
import 'package:toast/toast.dart';
import 'package:pinsmap/services/facebookLogin.dart';
import 'package:pinsmap/services/admob.dart';
import 'package:firebase_admob/firebase_admob.dart';

class SignUpPage extends StatelessWidget {
  adMob _ad = adMob();
  final facebook_login _facebookLogin = facebook_login();
  final GoogleSignInProvider _provider = GoogleSignInProvider();
  final AuthService _auth = AuthService();
  final AnalyticsService _analyticsService = locator<AnalyticsService>();

  String email = '';
  String password = '';
  String confirmpassword = '';

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
              height: 30,
            ),
            Container(
              child: Image.asset(
                'assets/logo2.png',
                height: 170,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              'Sign Up',
              style: Theme.of(context).textTheme.headline6!.merge(TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  )),
            ),
            SizedBox(
              height: 20,
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
                    height: 15,
                  ),
                  Container(
                    height: 50,
                    child: TextField(
                      onChanged: (v) {
                        confirmpassword = v;
                      },
                      decoration: new InputDecoration(
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
                        suffixIcon: Icon(
                          Icons.visibility_off_outlined,
                          size: 20,
                        ),
                        hintText: 'Confirm Password',
                        hintStyle: Theme.of(context).textTheme.caption!.merge(
                              TextStyle(fontSize: 12),
                            ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 18,
                        width: 18,
                        child: Checkbox(
                            value: true,
                            onChanged: (v) {
                              print(v.toString());
                            }),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            'Agree with',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .merge(TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.grey,
                                )),
                          ),
                          Container(
                            height: 20,
                            width: 45,
                            child: TextButton(
                              onPressed: () {},
                              child: Text('terms'),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 0)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0)),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'and',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .merge(TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.grey,
                                )),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Container(
                            height: 20,
                            child: TextButton(
                              onPressed: () {},
                              child: Text('conditions'),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 0)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0)),
                                ),
                              ),
                            ),
                          )
                        ],
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
                        print(password);
                        print(confirmpassword);
                        if (password == confirmpassword) {
                          print(confirmpassword);
                          dynamic result = await _auth
                              .registerwithEmailandPassword(email, password);
                          print(result.toString());

                          if (result == null) {
                            print("Somthing Wrong");
                          } else if (result ==
                              AuthResultStatus.emailAlreadyExists) {
                            displayToast(result, context);
                          } else if (result == AuthResultStatus.invalidEmail) {
                            displayToast(result, context);
                          } else if (result == AuthResultStatus.wrongPassword) {
                            displayToast(result, context);
                          } else if (result == AuthResultStatus.weakPassword) {
                            displayToast(result, context);
                          } else {
                            // await _analyticsService.logSignUp();
                            print(result.toString());
                            Get.to(() => SignInPage());
                          }
                        } else {
                          // "PASSWORD-NOT-MATCHED";
                          // Toast.show(
                          //   "Password Does Not Matched. Please Re Enter the Confirm Password",
                          //   context,
                          //   duration: 3,
                          // );
                          Fluttertoast.showToast(
                            msg:
                                "Password Does Not Matched. Please Re Enter the Confirm Password",
                          );
                        }
                      },
                      elevation: 0,
                      child: Text(
                        'Sign Up',
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.grey[350],
                    height: 1,
                    width: MediaQuery.of(context).size.width * 0.35,
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
                  Container(
                    color: Colors.grey[350],
                    height: 1,
                    width: MediaQuery.of(context).size.width * 0.35,
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
                        if (result == null) {
                          print("Somthing Wrong");
                        } else {
                          Get.offAll(HomeLayout());
                        }
                      },
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    child: IconButton(
                      padding: EdgeInsets.symmetric(vertical: 0),
                      icon: FaIcon(
                        FontAwesomeIcons.apple,
                        size: 24,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
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
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 70,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?'),
                  Container(
                    height: 20,
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => SignInPage());
                      },
                      child: Text('Sign In'),
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
            ),
          ],
        ),
      ),
    );
  }
}
