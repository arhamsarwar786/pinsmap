import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pinsmap/services/currentLocation.dart';
import 'package:location/location.dart';
import 'package:pinsmap/services/database.dart';
import 'package:pinsmap/src/components/HomeLayout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinsmap/services/admob.dart';
import 'package:firebase_admob/firebase_admob.dart';

class AddItemPage extends StatefulWidget {
  final String sname;
  final String fname;
  final String? latt;
  final String? lngg;
  final String? loname;
  const AddItemPage(this.sname, this.fname, this.latt, this.lngg, this.loname);
  @override
  State<AddItemPage> createState() =>
      AddItemPageState(sname, fname, latt, lngg, loname);
}

class AddItemPageState extends State<AddItemPage> {
  adMob _ad = adMob();
  String _editPage;
  String _feditPage;
  dynamic lattt;
  dynamic lnggg;
  dynamic locname;
  var txt = TextEditingController();

  dynamic _markers;

  AddItemPageState(
      this._editPage, this._feditPage, this.lattt, this.lnggg, this.locname);

  final currentLocation location = currentLocation();
  dynamic name;

  final databaseRef _db = databaseRef();
  Completer<GoogleMapController> _controller = Completer();

  // static final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(23.813275, 90.424384),
  //   zoom: 10,
  // );

  LocationData? _currentPosition;

  var lng, lat, loading;

  dynamic _fname, _editlat, _editlng;

  @override
  initState() {
    //_getLocation();
    if (_editPage == "true") {
      _edit();
    } else {
      if (lattt != null && lattt != "false") {
        setLocation(double.parse(lattt), double.parse(lnggg));
        txt.text = locname;
        name = locname;
        print('We Got it ${lattt}&&===>>  ${locname} ===>>> ${name}');
      } else {
        _getLocation();
      }
    }
    super.initState();
  }

  _edit() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? usr = await _auth.currentUser;
    // print(usr?.uid);
    dynamic uid = usr?.uid;
    await FirebaseFirestore.instance
        .collection("locations")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        print(element.data()["name"]);
        if (element.data()["userid"] == uid) {
          if (element.data()["name"] == _feditPage) {
            _editlat = element.data()["coordinates"]["latitude"];
            _editlng = element.data()["coordinates"]["longitude"];
            _fname = element.data()["name"];
          }
        }
        // _list.add(element.data()["name"]);
      });
    });
    if (_editPage == "true") {
      txt.text = await _fname;
      name = _fname;
    }
    setLocation(await _editlat, await _editlng);
  }

  setLocation(setlat, setlng) {
    setState(() {
      lat = setlat;
      lng = setlng;
      loading = false;
      print(lng);
      print(lat);

      _markers = Marker(
        markerId: MarkerId('user'),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: 'User'),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueViolet,
        ),
      );
    });
  }

  _getLocation() async {
    var location = new Location();
    try {
      _currentPosition = await location.getLocation();
      setState(() {
        lat = _currentPosition?.latitude;
        lng = _currentPosition?.longitude;
        loading = false;
        print(_currentPosition);
        print("_currentPosition");

        _markers = Marker(
          markerId: MarkerId('user'),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(title: 'User'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueViolet,
          ),
        );
      }); //rebuild the widget after getting the current location of the user
    } on Exception {
      _currentPosition = null;
    }
  }

  double zoomVal = 5.0;

  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-5741002225942405~5953238132")
        .then((response) {
      // _ad.myBanner..load()..show();
    });
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        title: Text(
          'New Item',
          style: Theme.of(context).textTheme.subtitle1!.merge(
                TextStyle(
                  // color: Color(0xffE50C0C),
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.offAll(HomeLayout());
              print('object');
              Get.offAll(HomeLayout());
            },
            child: Text(
              'Cancel',
            ),
          ),
          SizedBox(
            width: 16,
          )
        ],
      ),
      body: Stack(
        children: [
          loading == false
              ? GoogleMap(
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(lat, lng),
                    zoom: 15,
                  ),
                  onTap: _handleTap,
                  onLongPress: _handleTap,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: {
                    _markers,
                    // userMarker,
                  },
                )
              : Center(),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Container(
              width: Get.width,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 35),
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
                  TextField(
                    controller: txt,
                    onChanged: (v) async {
                      name = v;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 0.0,
                      ),
                      hintText: 'Name',
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
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 45,
                    width: Get.width,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 3),
                          blurRadius: 20.0,
                          color: Color(0xff5857C2).withOpacity(0.5),
                        )
                      ],
                    ),
                    child: MaterialButton(
                      onPressed: () async {
                        if (name != null) {
                          if (_editPage == "true") {
                            // lat = await _editlat;
                            // lng = await _editlng;
                            print(name + lat.toString() + lng.toString());
                            dynamic result =
                                await _db.update_Data(name, _fname, lat, lng);
                            if (result == true) {
                              Get.offAll(HomeLayout());
                            } else {
                              Fluttertoast.showToast(
                                msg: "Please Try Different Name for Location",                                
                              );
                              print("Somthing Wrong");
                            }
                          } else {
                            print(name + lat.toString() + lng.toString());
                            dynamic result =
                                await _db.insert_Data(name, lat, lng);
                            if (result == true) {
                              Get.offAll(HomeLayout());
                            } else {
                              Fluttertoast.showToast(
                                msg: "Please Try Different Name for Location",                                
                              );
                              print("Somthing Wrong! : ${result}");
                            }
                          }
                        } else {
                          print("name is null");
                        }
                      },
                      elevation: 0,
                      child: Text(
                        'Save',
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
          ),
          Positioned(
            right: 20,
            bottom: 235,
            child: Column(
              children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 3),
                        blurRadius: 20.0,
                        color: Colors.grey.withOpacity(0.5),
                      )
                    ],
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      print('add');
                      zoomVal++;
                      _plus(zoomVal);
                    },
                    elevation: 0,
                    child: Icon(
                      Icons.add,
                      size: 20,
                    ),
                    color: Colors.white,
                    // minWidth: Get.width,
                    padding: EdgeInsets.symmetric(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 3),
                        blurRadius: 20.0,
                        color: Colors.grey.withOpacity(0.5),
                      )
                    ],
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      print('remove');
                      zoomVal--;
                      _minus(zoomVal);
                    },
                    elevation: 0,
                    child: Icon(
                      Icons.remove,
                      size: 20,
                    ),
                    color: Colors.white,
                    // minWidth: Get.width,
                    padding: EdgeInsets.symmetric(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }

  Future<void> goCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(40.712776, -74.005974),
      zoom: 10,
    )));
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(40.712776, -74.005974), zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(40.712776, -74.005974), zoom: zoomVal)));
  }

  //=======================
  // Map Marker List
  //=======================

  _handleTap(LatLng point) {
    setState(() {
      _markers = Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: InfoWindow(
          title: 'I am a marker',
        ),
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      );
      lat = point.latitude;
      lng = point.longitude;
    });
  }

  // Marker userMarker = Marker(
  //   markerId: MarkerId('user'),
  //   position: LatLng(23.813275, 90.424384),
  //   infoWindow: InfoWindow(title: 'User'),
  //   icon: BitmapDescriptor.defaultMarkerWithHue(
  //     BitmapDescriptor.hueViolet,
  //   ),
  // );
}
