import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinsmap/src/pages/addItemPage.dart';
import 'package:pinsmap/services/checkPermissions.dart';

class PermissionPage extends StatelessWidget {
  final checkPermissions _checkPermissions = checkPermissions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5857C2),
      body: Stack(
        children: [
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ops!!',
                    style: Theme.of(context).textTheme.headline6!.merge(
                          TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 250,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'You have to allow this app to use your device location to allow you to add new locations and use navigation service.',
                    style: Theme.of(context).textTheme.subtitle2!.merge(
                          TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Click on the button below and select allow in this display message then enjoy :)',
                    style: Theme.of(context).textTheme.subtitle2!.merge(
                          TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 45,
              width: Get.width,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
              decoration: BoxDecoration(),
              child: MaterialButton(
                onPressed: () async {
                  dynamic permission =
                      await _checkPermissions.askForPermissions();
                  if (permission == true) {
                    Get.to(() => AddItemPage("false","false","false","false","false"));
                  } else {
                    print("Please Approve the Permissions");
                  }
                },
                elevation: 0,
                child: Text(
                  'Allow Permission',
                  style: Theme.of(context).textTheme.subtitle2!.merge(
                        TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xff5857C2),
                          fontSize: 14,
                        ),
                      ),
                ),
                color: Colors.white,
                // minWidth: Get.width,
                padding: EdgeInsets.symmetric(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
