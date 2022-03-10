import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinsmap/src/components/WelcomeLayout.dart';
import 'package:pinsmap/src/pages/addItemPage.dart';
import 'package:pinsmap/src/pages/detailsPage.dart';
import 'package:pinsmap/src/pages/gestureItem.dart';
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
import 'package:pinsmap/services/dynamic_links.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:pinsmap/src/pages/signInPage.dart';
import 'package:pinsmap/services/admob.dart';
import 'package:firebase_admob/firebase_admob.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final DynamicLinkService _dynamicLinkService = DynamicLinkService();
  final checkPermissions _checkPermissions = checkPermissions();
  bool menuOpen = false;
  double tranx = 0, trany = 0, scale = 1.0;

  dynamic search;

  adMob _ad = adMob();

  var _controller = ScrollController();

  final gmapsOpner _gmapsOpner = gmapsOpner();

  final databaseRef _databaseRef = databaseRef();
  List<String> t_name = [];
  List<String> search_name = [];
  List test_name = [];
  List temp_name = [];
  List _cordinates = [];
  bool show = false;
  List isoCode = [];
  List<Placemark> placemarks = [];

  void initState() {
    // _dynamicLinkService.handleDynamicLinks();
    handleDynamicLinks();
    _getList();
    super.initState();
  }

  _getList() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? usr = await _auth.currentUser;
    // print(usr?.uid);
    dynamic uid = usr?.uid;
    // dynamic _list = await _databaseRef.getLists();
    QuerySnapshot<Map<String, dynamic>> _lis = await FirebaseFirestore.instance
        .collection("locations")
        .where("userid", isEqualTo: uid)
        .orderBy('name')
        .get()
        .then((value) {
      return value;
    });
    if (_lis.docs.length == 0) {
      Get.offAll(WelcomeLayout());
    } else {
      setState(() {
        _lis.docs.forEach((element) {
          // if (element.data()["userid"] == uid) {
          test_name.add(element.data());
          t_name.add(element.data()["name"]);
          // _cordinates.add({
          //   "latitude": element.data()["coordinates"]["latitude"],
          //   "longitude": element.data()["coordinates"]["longitude"]
          // });
          isoCode.add(element.data()["country"]);
          // _lng.add(element.data()["coordinates"]["longlongitude"]);
          // } else {}
        });
        show = true;
        // test_name.sort();
        print(test_name);

        // t_name.sort();
        print(t_name.length);
        // temp_name.add(_list);
        // temp_name.forEach((element) {
        //   t_name.add(element);
        //   print(element);
        // });
      });
    }
    // _cordinates.forEach((element) async {
    //   print(element["latitude"]);
    //   placemarks = await placemarkFromCoordinates(
    //       element["latitude"], element["longitude"]);
    //   if (placemarks[0].isoCountryCode != null) {
    //     _isoCode(placemarks[0].isoCountryCode!.toLowerCase());
    //     // print(placemarks);
    //   }
    // });
    // placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
    // print(placemarks.length);
    // placemarks.forEach((element) {
    //   print(element.isoCountryCode);
    // });

    // print(isoCode);
    // isoCode.forEach((element) {
    //   print(element);
    // });
  }

  // _isoCode(iso_code){
  //   isoCode.add(iso_code);
  //   print(isoCode);
  // }

  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-5741002225942405~5953238132")
        .then((response) {
      _ad.myBanner
        ..load()
        ..show();
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
      child: show
          ? SingleChildScrollView(
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
                                    trany =
                                        (size.height - size.height * scale) / 2;

                                    setState(() {
                                      menuOpen = true;
                                    });
                                  },
                                )
                              : IconButton(
                                  icon: Icon(Icons.arrow_back,
                                      color: Colors.black),
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
                          Row(
                            children: [
                              Text(
                                'Pins ',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .merge(
                                      TextStyle(
                                        color: Color(0xffE50C0C),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                              ),
                              Text(
                                'Map',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .merge(
                                      TextStyle(
                                        color: Color(0xff5857C2),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        height: 30,
                        margin: EdgeInsets.symmetric(vertical: 12),
                        child: TextButton(
                          onPressed: () async {
                            // _checkPermissions.askForPermissions();
                            if (_checkPermissions.checkForServices == false) {
                              print("Your Device Doesn't Support Services");
                            } else {
                              dynamic permission =
                                  await _checkPermissions.checkforPermissions();
                              print(permission.toString());
                              if (permission == false) {
                                Get.to(() => PermissionPage());
                              } else {
                                Get.to(() => AddItemPage("false", "false","false", "false", "false"));
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
                                EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0)),
                            shape: MaterialStateProperty.all(
                              CircleBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 0),
                                blurRadius: 20.0,
                                color: Colors.black.withOpacity(0.1),
                              )
                            ]),
                            child: TextField(
                              onChanged: (v) async {
                                search = await v;

                                final FirebaseAuth _auth =
                                    FirebaseAuth.instance;
                                User? usr = await _auth.currentUser;
                                // print(usr?.uid);
                                dynamic uid = usr?.uid;

                                // dynamic _list = await _databaseRef.getLists();
                                QuerySnapshot<Map<String, dynamic>> _lis =
                                    await FirebaseFirestore.instance
                                        .collection("locations")
                                        .orderBy('name')
                                        .get()
                                        .then((value) {
                                  return value;
                                });
                                if (v == "" || v == null) {
                                  setState(() {
                                    t_name.clear();
                                    isoCode.clear();
                                    // print(t_name);
                                    print(search);
                                    _lis.docs.forEach((element) {
                                      if (element.data()["userid"] == uid) {
                                        print(element.data());
                                        t_name.add(element.data()["name"]);
                                        isoCode.add(element.data()["country"]);
                                      } else {}
                                    });
                                    // t_name.sort();
                                    print(t_name.length);
                                    // temp_name.add(_list);
                                    // temp_name.forEach((element) {
                                    //   t_name.add(element);
                                    //   print(element);
                                    // });
                                  });
                                }
                              },
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 0.0,
                                ),
                                prefixIcon: Icon(Icons.search_rounded),
                                hintText: 'Type here',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .merge(TextStyle(fontSize: 12)),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 0.0,
                                    style: BorderStyle.none,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 0.0,
                                    style: BorderStyle.none,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 0.0,
                                    style: BorderStyle.none,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 39,
                          width: 60,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 0),
                                blurRadius: 20.0,
                                color: Color(0xff5857C2).withOpacity(0.3),
                              )
                            ],
                          ),
                          child: MaterialButton(
                            onPressed: () async {
                              search_name.clear();
                              _cordinates.clear();
                              t_name.clear();
                              isoCode.clear();
                              final FirebaseAuth _auth = FirebaseAuth.instance;
                              User? usr = await _auth.currentUser;
                              // print(usr?.uid);
                              dynamic uid = usr?.uid;

                              // dynamic _list = await _databaseRef.getLists();
                              QuerySnapshot<Map<String, dynamic>> _lis =
                                  await FirebaseFirestore.instance
                                      .collection("locations")
                                      .orderBy('name')
                                      .get()
                                      .then((value) {
                                return value;
                              });
                              setState(() {
                                print(search);
                                if (search != null || search != "") {
                                  _lis.docs.forEach((element) {
                                    if (element.data()["userid"] == uid) {
                                      search_name.add(element.data()["name"]);
                                      t_name = search_name
                                          .where(
                                              (ele) => ele.indexOf(search) > -1)
                                          .toList();
                                      // if (element.data()["name"] == search) {
                                      //   t_name.clear();
                                      //   t_name.add(element.data()["name"]);
                                      //   print(t_name);
                                      //   print(search + "search");
                                      // }
                                      t_name.forEach((el) {
                                        if (element.data()["name"] == el) {
                                          isoCode
                                              .add(element.data()["country"]);
                                          print('${el}t_name');
                                        }
                                      });
                                    } else {}
                                  });
                                }
                                if (search == "" || search == null) {
                                  t_name.clear();
                                  // print(t_name);
                                  print(search);
                                  _lis.docs.forEach((element) {
                                    if (element.data()["userid"] == uid) {
                                      print(element.data());
                                      t_name.add(element.data()["name"]);
                                    } else {}
                                  });
                                }
                                // t_name.sort();
                                print(t_name.length);
                                // temp_name.add(_list);
                                // temp_name.forEach((element) {
                                //   t_name.add(element);
                                //   print(element);
                                // });
                              });
                              t_name.forEach((element) {
                                print(element);
                              });
                            },
                            elevation: 0,
                            child: Text(
                              'Search',
                              style: Theme.of(context).textTheme.caption!.merge(
                                    TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                            ),
                            color: Color(0xff5857C2),
                            // minWidth: Get.width,
                            padding: EdgeInsets.symmetric(),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
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
                    height: 500,
                    width: Get.width,
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
                    child: ListView.builder(
                        itemCount: t_name.length,
                        shrinkWrap: true,
                        primary: false,
                        controller: _controller,
                        itemBuilder: (BuildContext context, index) {
                          return GestureItem(
                              t_name: t_name[index].toString(),
                              isoCode: isoCode[index].toString());
                        }),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                ],
              ),
            )
          : Container(),
    );
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     print("doing..");
  //     _dynamicLinkService.handleDynamicLinks();
  //   }
  // }

  void handleDynamicLinks() async {
    ///To bring INTO FOREGROUND FROM DYNAMIC LINK.
    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData? dynamicLinkData) async {
        await _handleDeepLink(dynamicLinkData);
      },
      onError: (OnLinkErrorException e) async {
        print('DynamicLink Failed: ${e.message}');
        return e.message;
      },
    );

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    _handleDeepLink(data);
  }

  // bool _deeplink = true;
  _handleDeepLink(PendingDynamicLinkData? data) async {
    final Uri? deeplink = data!.link;
    if (deeplink != null) {
      final queryParams = deeplink.queryParameters;
      print("parameters of link ${queryParams}");
      if (FirebaseAuth.instance.currentUser != null) {
        if (queryParams.length > 0) {
          String? lat = queryParams['lat'];
          String? lng = queryParams['lng'];
          String? name = queryParams['name'];
          Get.to(AddItemPage("false", "false",lat,lng,name));
        }
      } else {
        Get.to(SignInPage());
      }
      print('Handling Deep Link | deepLink: ${deeplink} ===> ${data} ');
    }
  }
}
