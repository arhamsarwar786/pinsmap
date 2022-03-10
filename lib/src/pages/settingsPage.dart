import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinsmap/services/auth.dart';
import 'package:pinsmap/src/components/HomeLayout.dart';
import 'package:pinsmap/services/admob.dart';
import 'package:firebase_admob/firebase_admob.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  adMob _ad = adMob();
  bool menuOpen = false;
  final AuthService _auth = AuthService();
  final oldPass = TextEditingController();
  final newPass = TextEditingController();
  final confPass = TextEditingController();

  String oldpassword = "";
  String newpassword = "";
  String confirmpassword = "";

  String? dropdownvalue;
  var items = [
    'Small',
    'Medium',
    'Large',
  ];

  double tranx = 0, trany = 0, scale = 1.0;

  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-5741002225942405~5953238132").then((response){
      _ad.myBanner..load()..show();
    });
    var size = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      transform: Matrix4.translationValues(tranx, trany, 0)..scale(scale),
      height: Get.height,
      decoration: BoxDecoration(
        color: Color(0xffF8F8FF),
        boxShadow: [
          BoxShadow(
            offset: Offset(-13, 10),
            blurRadius: 0.0,
            color: Colors.white.withOpacity(0.4),
          ),
          BoxShadow(
            offset: Offset(-24, 20),
            blurRadius: 0.0,
            color: Colors.white.withOpacity(0.5),
          )
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(menuOpen ? 25 : 0),
          bottomLeft: Radius.circular(menuOpen ? 25 : 0),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    !menuOpen
                        ? IconButton(
                            icon: Icon(Icons.sort, color: Colors.black),
                            onPressed: () {
                              scale = 0.7;
                              tranx = size.width - 170;
                              trany = (size.height - size.height * scale) / 2;

                              setState(() {
                                menuOpen = true;
                              });
                            },
                          )
                        : IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.black),
                            onPressed: () {
                              tranx = 0;
                              trany = 0;
                              scale = 1.0;
                              setState(() {
                                menuOpen = false;
                              });
                            },
                          ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      'Settings',
                      style: Theme.of(context).textTheme.subtitle1!.merge(
                            TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              // height: 500,
              width: Get.width,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 20.0,
                    color: Colors.black.withOpacity(0.1),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Change Password',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .merge(TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextField(
                    onChanged: (v) {
                      if (v.length > 6) {
                        oldpassword = v;
                      } else {
                        print("password must be at least 7 characters");
                      }
                    },
                    keyboardType: TextInputType.text,
                    controller: oldPass,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 0.0,
                      ),
                      suffixIcon: Icon(
                        Icons.visibility_off_outlined,
                        size: 20,
                      ),
                      hintText: 'Current Password',
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
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    onChanged: (v) {
                      if (v.length > 6) {
                        newpassword = v;
                      } else {
                        print("password must be at least 7 characters");
                      }
                    },
                    keyboardType: TextInputType.text,
                    controller: newPass,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 0.0,
                      ),
                      suffixIcon: Icon(
                        Icons.visibility_off_outlined,
                        size: 20,
                      ),
                      hintText: 'New Password',
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
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    onChanged: (v) {
                      if (v.length > 6) {
                        confirmpassword = v;
                      } else {
                        print("password must be at least 7 characters");
                      }
                    },
                    keyboardType: TextInputType.text,
                    controller: confPass,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 0.0,
                      ),
                      suffixIcon: Icon(
                        Icons.visibility_off_outlined,
                        size: 20,
                      ),
                      hintText: 'Confirm Password',
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
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 45,
                    width: Get.width,
                    decoration: BoxDecoration(),
                    child: MaterialButton(
                      onPressed: () async {
                        if (newpassword != confirmpassword) {
                          print("Password is Not Matched");
                          oldPass.clear();
                          newPass.clear();
                          confPass.clear();
                        } else {
                          dynamic result = await _auth.changePassword(
                              oldpassword, newpassword);
                          if (result != null) {
                            oldPass.clear();
                            newPass.clear();
                            confPass.clear();
                            print(result.toString());
                            Get.offAll(HomeLayout());
                          } else {
                            oldPass.clear();
                            newPass.clear();
                            confPass.clear();
                            print("Please enter Correct Password");
                          }
                        }
                      },
                      elevation: 0,
                      child: Text(
                        'Change Password',
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
              height: 30,
            ),
            Container(
              width: Get.width,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 20.0,
                    color: Colors.black.withOpacity(0.1),
                  )
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'List Font Size',
                    style:
                        Theme.of(context).textTheme.headline6!.merge(TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            )),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    // height: 45,
                    padding: EdgeInsets.fromLTRB(15, 0, 10, 3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: Color(0xff5857C2),
                        width: 0.5,
                      ),
                    ),
                    child: DropdownButton(
                      value: dropdownvalue,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 20,
                        color: Colors.black,
                      ),
                      isExpanded: true,
                      hint: Text('Select Font Size'),
                      dropdownColor: Colors.white,
                      underline: Container(),
                      style:
                          Theme.of(context).textTheme.caption!.merge(TextStyle(
                                fontWeight: FontWeight.w400,
                              )),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          dropdownvalue = newValue.toString();
                        });
                        print(dropdownvalue);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 160,
            ),
          ],
        ),
      ),
    );
  }
}
