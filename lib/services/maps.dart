import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share/share.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class gmapsOpner {
  dynamic name;
  List _name = [];
  Future setName(String name) async {
    if (name != null) {
      _name.add(name);
      // print(this.name);
      this.name = await name;
      print(this.name);
    }
    return true;
  }

  Future getName() async {
    print(_name);
    return this.name;
  }

  Future startDirections(dynamic _name) async {
    var location = new Location();
    LocationData currentLocation;
    currentLocation = await location.getLocation();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? usr = await _auth.currentUser;
    // print(usr?.uid);
    dynamic uid = usr?.uid;

    dynamic lat, lng;
    await FirebaseFirestore.instance
        .collection("locations")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        print(element.data()["name"]);
        if (element.data()["userid"] == uid) {
          if (element.data()["name"] == _name) {
            lat = element.data()["coordinates"]["latitude"];
            lng = element.data()["coordinates"]["longitude"];
          }
        }
        // _list.add(element.data()["name"]);
      });
    });

    print(lat);
    print(lng);
    await launch(
      'https://www.google.com/maps/dir/?api=1&origin=${currentLocation.latitude},${currentLocation.longitude}&destination=${lat},${lng}&travelmode=driving&dir_action=navigate');
       // 'https://www.google.com/maps/dir/${currentLocation.latitude},${currentLocation.longitude}/${lat},${lng}/data=!3m1!4b1!4m14!4m13!1m5!1m1!1s0x395e848aba5bd449:0x4fcedd11614f6516!2m2!1d${currentLocation.latitude}!${currentLocation.longitude}!1m5!1m1!1s0x3962fcad1b410ddb:0x96ec4da356240f4!2m2!1d${lat}!${lng}!3e0');
    // https://www.google.com/maps/dir/20.593684,78.96288/37.4220121,-122.085118
  }

  Future startWalk(dynamic _name) async {
    var location = new Location();
    LocationData currentLocation;
    currentLocation = await location.getLocation();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? usr = await _auth.currentUser;
    // print(usr?.uid);
    dynamic uid = usr?.uid;

    dynamic lat, lng;
    await FirebaseFirestore.instance
        .collection("locations")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        print(element.data()["name"]);
        if (element.data()["userid"] == uid) {
          if (element.data()["name"] == _name) {
            lat = element.data()["coordinates"]["latitude"];
            lng = element.data()["coordinates"]["longitude"];
          }
        }
        // _list.add(element.data()["name"]);
      });
    });

    print(lat);
    print(lng);
    await launch(
      'https://www.google.com/maps/dir/?api=1&origin=${currentLocation.latitude},${currentLocation.longitude}&destination=${lat},${lng}&travelmode=walking&dir_action=navigate');
        //'https://www.google.com/maps/dir/${currentLocation.latitude},${currentLocation.longitude}/${lat},${lng}/data=!3m1!4b1!4m6!4m5!1m1!4e1!1m1!4e1!3e2');        
    // https://www.google.com/maps/dir/20.593684,78.96288/37.4220121,-122.085118
  }

  Future openMap(dynamic _name) async {
    var location = new Location();
    // LocationData currentLocation;
    // currentLocation = await location.getLocation();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? usr = await _auth.currentUser;
    // print(usr?.uid);
    dynamic uid = usr?.uid;

    dynamic lat, lng;
    await FirebaseFirestore.instance
        .collection("locations")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        print(element.data()["name"]);
        if (element.data()["userid"] == uid) {
          if (element.data()["name"] == _name) {
            lat = element.data()["coordinates"]["latitude"];
            lng = element.data()["coordinates"]["longitude"];
          }
        }
        // _list.add(element.data()["name"]);
      });
    });

    print(lat);
    print(lng);
    await launch(
        'https://www.google.com/maps/search/?api=1&query=${lat},${lng}');
    // https://www.google.com/maps/dir/20.593684,78.96288/37.4220121,-122.085118
  }

  Future shareLocation(dynamic _name) async {
    var location = new Location();
    // LocationData currentLocation;
    // currentLocation = await location.getLocation();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? usr = await _auth.currentUser;
    // print(usr?.uid);
    dynamic uid = usr?.uid;

    dynamic lat, lng;
    await FirebaseFirestore.instance
        .collection("locations")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        print(element.data()["name"]);
        if (element.data()["userid"] == uid) {
          if (element.data()["name"] == _name) {
            lat = element.data()["coordinates"]["latitude"];
            lng = element.data()["coordinates"]["longitude"];
          }
        }
        // _list.add(element.data()["name"]);
      });
    });

    print(lat);
    print(lng);
    print ("we got name ==>>> ${_name}");
    String link = await createDynamicLink(await lat, await lng, await _name);
    await Share.share('PinsMap: Hey This is My Shared Location : ${link} Please Save It For Later Use!');
    // await launch(
    //     'https://www.google.com/maps/search/?api=1&query=${lat},${lng}');
    // https://www.google.com/maps/dir/20.593684,78.96288/37.4220121,-122.085118
  }

  Future<String> createDynamicLink(lat, lng, name) async {

  var parameters = DynamicLinkParameters(
    uriPrefix: 'https://pinsmapziad.page.link/',
    link: Uri.parse('https://pinsmapziad/items?lat=${await lat}&lng=${await lng}&name=${await name}'),
    androidParameters: AndroidParameters(
      packageName: "com.ziad1.pinsmap",
    ),
    iosParameters: IosParameters(
      bundleId: "com.exmple.test",
      appStoreId: '1498909115',
    ),
  );
  var dynamicUrl = await parameters.buildUrl();
  var shortLink = await parameters.buildShortLink();
  var shortUrl = shortLink.shortUrl;

  return shortUrl.toString();
}

}
