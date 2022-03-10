import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinsmap/src/components/AlertWidget.dart';
import 'package:pinsmap/services/maps.dart';
import 'package:pinsmap/src/pages/addItemPage.dart';
import 'package:pinsmap/services/admob.dart';
import 'package:firebase_admob/firebase_admob.dart';

class DetailsPage extends StatefulWidget {  
  final String sname,cname;
  const DetailsPage(this.sname, this.cname);
  @override
  DetailsPageState createState() => DetailsPageState(sname,cname);
}

class DetailsPageState extends State<DetailsPage> {
  
  String _Locname, _countryName;
  adMob _ad = adMob();

  DetailsPageState(this._Locname, this._countryName);

  // List Loc = [];

  // detailsPag(String name) async {
  //   Loc.add(name);
  //   this._Locname = await name;
  //   print(_Locname+"get");
  // }
  final gmapsOpner _gmapsOpner = gmapsOpner();

  dynamic _name;
  
  void initState() {
    // _getName();
    // print(_Locname.toString());
    super.initState();    
  }

  // _getName() async {
  //   print(_Locname);
  //   _name = await _gmapsOpner.getName().toString();
  //   print(_name);
  // }

  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-5741002225942405~5953238132").then((response){
      _ad.myBanner..load()..show();
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        title: Text(
          'Details',
          style: Theme.of(context).textTheme.subtitle1!.merge(
                TextStyle(
                  // color: Color(0xffE50C0C),
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        actions: [
          Container(
            width: 45,
            margin: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(),
            child: MaterialButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertWidget(
                      title: 'Confirmation',
                      content: 'Are you sure you want to clear order data?',
                      Locname: _Locname,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
              elevation: 0,
              child: Text(
                'Delete',
                style: Theme.of(context).textTheme.caption!.merge(
                      TextStyle(
                        color: Color(0xffE50C0C),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(.0),
              ),
            ),
          ),
          Container(
            width: 45,
            margin: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(),
            child: MaterialButton(
              onPressed: () {
                Get.to(() => AddItemPage("true",_Locname,"false","false","false"));
              },
              elevation: 0,
              child: Text(
                'Edit',
                style: Theme.of(context).textTheme.caption!.merge(
                      TextStyle(
                        color: Color(0xff5857C2),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
              ),
              // color: Color(0xff5857C2),
              // minWidth: Get.width,
              padding: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(.0),
              ),
            ),
          ),
          SizedBox(
            width: 16,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                            'https://flagcdn.com/120x90/${_countryName}.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        _Locname,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .merge(TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Address:',
                    style:
                        Theme.of(context).textTheme.headline6!.merge(TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            )),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 45,
                    width: Get.width,
                    decoration: BoxDecoration(),
                    child: MaterialButton(
                      onPressed: () async{
                        _gmapsOpner.startDirections(_Locname);
                      },
                      elevation: 0,
                      child: Text(
                        'Start Directions',
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
                    height: 15,
                  ),
                  Container(
                    height: 45,
                    width: Get.width,
                    decoration: BoxDecoration(),
                    child: MaterialButton(
                      onPressed: () {
                        _gmapsOpner.openMap(_Locname);
                      },
                      elevation: 0,
                      child: Text(
                        'Open Map',
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
                    height: 15,
                  ),
                  Container(
                    height: 45,
                    width: Get.width,
                    decoration: BoxDecoration(),
                    child: MaterialButton(
                      onPressed: () {
                        _gmapsOpner.startWalk(_Locname);
                      },
                      elevation: 0,
                      child: Text(
                        'Start Walking',
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
                    height: 15,
                  ),
                  Container(
                    height: 45,
                    width: Get.width,
                    decoration: BoxDecoration(),
                    child: MaterialButton(
                      onPressed: () {
                        _gmapsOpner.shareLocation(_Locname);
                      },
                      elevation: 0,
                      child: Text(
                        'Share Location',
                        style: Theme.of(context).textTheme.subtitle2!.merge(
                              TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                      ),
                      color: Color(0xffE50C0C),
                      // minWidth: Get.width,
                      padding: EdgeInsets.symmetric(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
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
