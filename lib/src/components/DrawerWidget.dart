import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinsmap/src/components/AboutLayout.dart';
import 'package:pinsmap/src/components/HomeLayout.dart';
import 'package:pinsmap/src/components/SettingsLayout.dart';
import 'package:pinsmap/src/components/WelcomeLayout.dart';
import 'package:pinsmap/src/pages/signInPage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pinsmap/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinsmap/services/analytics.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
// class DrawerWidget extends StatelessWidget {

  final AuthService _auth = AuthService();
  dynamic email, tempEmail, name, letter;

  void initState() {
    getEmail();
    super.initState();
  }

  getEmail() async {
    tempEmail = await _auth.getCurrentUserEmail();
    setState(() {
      email = tempEmail;
      name = email.substring(0, email.indexOf('@'));
      letter = name.substring(0, 1);
    });
    print(email);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff5857C2),
      height: Get.height,
      padding: EdgeInsets.only(bottom: 70),
      child: SingleChildScrollView(

        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
            
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                leading: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: letter != null
                      ? CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          backgroundImage: NetworkImage(
                              'https://img.icons8.com/ios-filled/50/000000/marker-${letter}.png'),
                        )
                      : Container(),
                ),
                title: Text(
                  name != null ? name : "",
                  style: Theme.of(context).textTheme.subtitle1!.merge(
                        TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                ),
                subtitle: Text(
                  email != null ? email : "",
                  style: Theme.of(context).textTheme.caption!.merge(
                        TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[300],
                          fontSize: 12,
                        ),
                      ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => HomeLayout());
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 8),
                      padding: EdgeInsets.symmetric(vertical: 6),
                      // color: Colors.amber,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(3)),
                            child: Icon(
                              Icons.home_outlined,
                              color: Colors.grey[200],
                              size: 20,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Home',
                            style: Theme.of(context).textTheme.caption!.merge(
                                  TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[300],
                                    fontSize: 14,
                                  ),
                                ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.to(() => WelcomeLayout());
                  //   },
                  //   behavior: HitTestBehavior.opaque,
                  //   child: Container(
                  //     margin: EdgeInsets.only(bottom: 8),
                  //     padding: EdgeInsets.symmetric(vertical: 6),
                  //     // color: Colors.amber,
                  //     child: Row(
                  //       children: [
                  //         Container(
                  //           padding: EdgeInsets.all(3),
                  //           decoration: BoxDecoration(
                  //               color: Colors.white.withOpacity(0.3),
                  //               borderRadius: BorderRadius.circular(3)),
                  //           child: Icon(
                  //             Icons.folder_open_rounded,
                  //             color: Colors.grey[200],
                  //             size: 20,
                  //           ),
                  //         ),
                  //         SizedBox(
                  //           width: 10,
                  //         ),
                  //         Text(
                  //           'Browser',
                  //           style: Theme.of(context).textTheme.caption!.merge(
                  //                 TextStyle(
                  //                   fontWeight: FontWeight.w500,
                  //                   color: Colors.grey[300],
                  //                   fontSize: 14,
                  //                 ),
                  //               ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => SettingsLayout());
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 8),
                      padding: EdgeInsets.symmetric(vertical: 6),
                      // color: Colors.amber,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(3)),
                            child: Icon(
                              Icons.settings,
                              color: Colors.grey[200],
                              size: 20,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Settings',
                            style: Theme.of(context).textTheme.caption!.merge(
                                  TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[300],
                                    fontSize: 14,
                                  ),
                                ),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => AboutLayout());
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 8),
                      padding: EdgeInsets.symmetric(vertical: 6),
                      // color: Colors.amber,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(3)),
                            child: Icon(
                              Icons.info_outline_rounded,
                              color: Colors.grey[200],
                              size: 20,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'About',
                            style: Theme.of(context).textTheme.caption!.merge(
                                  TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[300],
                                    fontSize: 14,
                                  ),
                                ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height / 2.3,
                  ),
                  GestureDetector(
                    onTap: () {
                      _auth.signOut();
                      googleSignIn.signOut();
                      Get.offAll(SignInPage());
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      // color: Colors.amber,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(3)),
                            child: Icon(
                              Icons.logout_outlined,
                              color: Colors.grey[200],
                              size: 20,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Sign Out',
                            style: Theme.of(context).textTheme.caption!.merge(
                                  TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[300],
                                    fontSize: 14,
                                  ),
                                ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Developed by Ziad Torkey',
                        style: Theme.of(context).textTheme.caption!.merge(
                              TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[300],
                                fontSize: 14,
                              ),
                            ),
                      ),
                      // Container(
                      //   height: 20,
                      //   child: TextButton(
                      //     onPressed: () async {
                      //       final _url = 'https://flutter.dev';
                      //       if (await canLaunch(_url)) {
                      //         await launch(
                      //           _url,
                      //           forceSafariVC: false,
                      //         );
                      //       }
                      //     },
                      //     child: Text('COORDD'),
                      //     style: ButtonStyle(
                      //       padding: MaterialStateProperty.all(
                      //           EdgeInsets.symmetric(
                      //               horizontal: 0, vertical: 0)),
                      //       shape: MaterialStateProperty.all(
                      //         RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(0)),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
