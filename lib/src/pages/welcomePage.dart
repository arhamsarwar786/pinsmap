import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinsmap/src/components/StyleScheme.dart';
import 'package:pinsmap/src/pages/addItemPage.dart';
import 'package:pinsmap/src/pages/permissionPage.dart';
import 'package:pinsmap/services/checkPermissions.dart';
import 'package:pinsmap/services/admob.dart';
import 'package:firebase_admob/firebase_admob.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  adMob _ad = adMob();
  bool menuOpen = false;

  final checkPermissions _checkPermissions = checkPermissions();

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
                  ],
                ),
                Container(
                  height: 30,
                  margin: EdgeInsets.symmetric(vertical: 12),
                  child: TextButton(
                    onPressed: () async{
                      // Get.to(() => AddItemPage("false","false"));

                      if (_checkPermissions.checkForServices == false) {
                        print("Your Device Doesn't Support Services");
                      } else {
                        dynamic permission =
                            await _checkPermissions.checkforPermissions();
                        print(permission.toString());
                        if (permission == false) {
                          Get.to(() => PermissionPage());
                        } else {
                          Get.to(() => AddItemPage("false", "false","false","false","false"));
                        }
                      }
                    },
                    child: Icon(
                      Icons.add,
                      size: 20,
                      color: Colors.white,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xff5857C2),
                      ),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
                      shape: MaterialStateProperty.all(
                        CircleBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: Image.network(
                'https://media.istockphoto.com/illustrations/globe-world-map-with-locaction-pin-points-illustration-illustration-id610667932?k=20&m=610667932&s=170667a&w=0&h=-PjnNa-0JXs7SVymiRLch_1GRc5NcF9HTtYE15u_pHc=',
                height: 200,
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
                    'Welcome To ',
                    style: Theme.of(context).textTheme.subtitle1!.merge(
                          TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  ),
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
                    'Map!',
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
              height: 20,
            ),
            Container(
              width: Get.width,
              margin: EdgeInsets.symmetric(horizontal: 40),
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
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
                children: [
                  Container(
                    child: Text(
                      'To Add Your First Location, Follow\nThe Following Steps',
                      style: Theme.of(context).textTheme.subtitle1!.merge(
                            TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 8, top: 30),
                        width: 4,
                        // height: 155,
                        color: Colors.grey[500],
                      ),
                      Column(
                        children: [
                          statusWidget(
                              "Tap + to open the map",
                              true),
                          statusWidget(
                              "Pick a place, tap a marker, or touch and hold a spot on the map",
                              false),
                          statusWidget(
                              "Provide a suitable label for the location",
                              false),
                          statusWidget(
                              "Tap on SAVE button to save the location",
                              false),
                        ],
                      )
                    ],
                  ),
                ],
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

  Container statusWidget(String status, bool isActive) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 13),
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (isActive) ? Colors.white : Colors.transparent,
                border: Border.all(
                    color: (isActive) ? Color(0xff5857C2) : Colors.orange,
                    width: isActive ? 2 : 0)),
            child: Container(
              height: 15,
              width: 15,
              margin: EdgeInsets.all(1.8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (isActive)
                    ? Color(0xff5857C2)
                    : Color(0xA875EC).withOpacity(1),
              ),
              // child: ,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              status,
              maxLines: 2,
              style: contentStyle.copyWith(
                  color: (isActive) ? Color(0xff5857C2) : Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
