import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinsmap/src/components/WelcomeLayout.dart';
import 'package:pinsmap/src/pages/addItemPage.dart';
import 'package:pinsmap/src/pages/detailsPage.dart';
import 'package:pinsmap/src/pages/permissionPage.dart';
import 'package:pinsmap/services/checkPermissions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinsmap/services/database.dart';
import 'package:pinsmap/services/maps.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:geocoder/geocoder.dart';
import 'package:geocode/geocode.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart';
import 'package:pinsmap/services/admob.dart';
import 'package:firebase_admob/firebase_admob.dart';

class GestureItem extends StatefulWidget {
  String t_name;
  String isoCode;
  GestureItem({this.t_name="", this.isoCode=""});
  @override
  _GestureItemState createState() => _GestureItemState();
}

class _GestureItemState extends State<GestureItem> {

  adMob _ad = adMob();

  final gmapsOpner _gmapsOpner = gmapsOpner();

  double xdir=0;
  void initState() {

    super.initState();
  }


  // _isoCode(iso_code){
  //   isoCode.add(iso_code);
  //   print(isoCode);
  // }

  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-5741002225942405~5953238132").then((response){
      _ad.myBanner..load()..show();
    });
    var size = MediaQuery.of(context).size;
    return Container(
        child:Container(
      width: double.infinity,
                      child:
                      Column(
                        children: [
                      Stack(
                      children:[
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color:Color(0xff5857C2),
                            ),
                            padding: EdgeInsets.only(bottom: 10, top: 10,left: 6,right: 6),
                          child: Row(
                            children: [
                                  Text("Start Directions",style: TextStyle(color: Colors.white),),
                            Spacer(),
                                  Text("Start Walking",style: TextStyle(color: Colors.white),)
                                ],
                              )
                        ),
                          Container(
                              margin: EdgeInsets.fromLTRB(xdir>0?xdir:0, 0,xdir<0?xdir*(-1):0,0),
                              child: GestureDetector(
                              onTap: () {
                                Get.to(() => DetailsPage(widget.t_name,widget.isoCode));
                                // _gmapsOpner.setName(t_name[index]);
                              },
                              onPanUpdate: (details) {
                                setState(() {
                                  xdir+=(details.delta.dx)/2;
                                });

                              },
                              onPanEnd: (details) {
                                if(xdir>size.width*0.15){
                                  //executestartdirections
                                  print("executestartdirections");
                                  _gmapsOpner.startDirections(widget.t_name);
                                }
                                else if(xdir*(-1)>size.width*0.15){
                                  //executestartwalking
                                  print("executestartwalking");
                                  _gmapsOpner.startWalk(widget.t_name);
                                }
                                setState(() {
                                xdir=0;
                              });
                              },
                              child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(left: 6,right: 6),
                                  child:
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 6, top: 6),
                                      child:Row(
                                children: [
                                  Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        'https://flagcdn.com/120x90/${widget.isoCode}.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.t_name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .merge(TextStyle(
                                      fontWeight: FontWeight.w600,
                                    )),
                                  ),
                                ],
                              ))),
                            ),
                          ),]),
                          Container(
                            padding: EdgeInsets.only(bottom: 6, top: 6),
                            child:  Divider(
                            height: 0.5,
                            thickness: 0.0,
                            indent: 0.0,
                            color: Colors.grey,
                          ),
                          )
                        ],
                      ),
  ));
  }
}
