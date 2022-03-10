import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinsmap/services/admob.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  adMob _ad = adMob();
  bool menuOpen = false;

  double tranx = 0, trany = 0, scale = 1.0;

  List<String> content = <String>[
    'PinsMap developed by Ziad Torkey',
    'PinsMap designed by Hind Torkey',
    'PinsMap First Release at 2022'
  ];

  // List<String> boldContent = <String>['Ziad Torkey', 'Hind Torkey', '2020'];

  @override
  Widget build(BuildContext context) {
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
                      'About',
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
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: Image.network(
                'https://www.sayma.es/wp-content/uploads/2020/05/gestion_proyectos.png',
                height: 250,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Pins ',
                    style: Theme.of(context).textTheme.subtitle1!.merge(
                          TextStyle(
                            color: Color(0xffE50C0C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  ),
                  Text(
                    'Map v1.0',
                    style: Theme.of(context).textTheme.subtitle1!.merge(
                          TextStyle(
                            color: Color(0xff5857C2),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'This app was developed to help Map users to save their favourite locations easily and view them in a simple list.',
                style: Theme.of(context).textTheme.subtitle1!.merge(
                      TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 0,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (BuildContext context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          maxRadius: 5,
                          backgroundColor: Color(0xff5857C2),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          content[index],
                          style: Theme.of(context).textTheme.caption!.merge(
                                TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                        ),
                        // Text(
                        //   content[index],
                        //   style: Theme.of(context).textTheme.caption!.merge(
                        //         TextStyle(
                        //           fontWeight: FontWeight.w500,
                        //           fontSize: 14,
                        //         ),
                        //       ),
                        // ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 45,
              margin: EdgeInsets.symmetric(horizontal: 40),
              width: Get.width,
              decoration: BoxDecoration(),
              child: MaterialButton(
                onPressed: () {
                  launch('mailto:ziadftorkey@gmail.com');
                },
                elevation: 0,
                child: Text(
                  'Contact Us',
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
            SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
    );
  }
}
