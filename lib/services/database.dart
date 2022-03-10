import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pinsmap/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';

class databaseRef {
  final AuthService _authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _locationReference =
      FirebaseDatabase.instance.reference().child('locations_data');
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future insertData(dynamic _Locationname, dynamic lat, dynamic lng) async {
    User? usr = await _auth.currentUser;
    // print(usr?.uid);
    dynamic uid = usr?.uid;
    // dynamic key = _locationReference.child(uid).get().then((value) => {
    //   value.value
    // });
    // print(key);

    dynamic snap = await _database
        .reference()
        .child('locations_data')
        .child(uid)
        .get()
        .then((DataSnapshot? snapshot) => {snapshot!.value});

    dynamic snaps;
    Map<dynamic, dynamic> val =
        await _locationReference.child(uid).get().then((DataSnapshot snapshot) {
      return snapshot.value;
    });

    List keys = [];
    val.forEach((key, value) {
      keys.add(key);
    });

    // print(val.length);

    DataSnapshot status =
        await _locationReference.child(uid).child(_Locationname).get();
    print(status.value);
    if (status.value != null) {
      print("false");
      return false;
    } else {
      _locationReference
          .child(uid)
          .child(_Locationname)
          .set({"latitude": lat, "longitude": lng});
      print("true");
      return true;
    }

    //  await _locationReference.child(uid).once().then((DataSnapshot snapshot) {
    //   Map<dynamic, dynamic> values = snapshot.value;
    //   values.forEach((key, values) {
    //     if(key == _Locationname){
    //       print("null");
    //       snaps = null;
    //     }else{
    //       print("data");
    // _locationReference.child(uid).child(_Locationname).set({"latitude":lat, "longitude":lng});
    //       snaps = true;
    //     }
    //     print(key);
    //   });
    // });
    // print(await snaps);
    // if (snaps == null) {
    //   return false;
    // } else {
    //   return true;
    // }
    // print(key);
    // print(snap);
    // for(dynamic snapshot in snap){
    //   if(snapshot[_Locationname] == ){
    //     print(snapshot[_Locationname]);
    //   }
    // }
  }

  Future insert_Data(dynamic _Locationname, dynamic lat, dynamic lng) async {
    User? usr = await _auth.currentUser;
    // print(usr?.uid);
    dynamic uid = usr?.uid;

    dynamic status;
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    await _firestore.collection("locations").get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        if (element.data()["name"] == _Locationname &&
            element.data()["userid"] == uid) {
          print(element.data()["name"]);
          status = false;
        }
      });
    });

    if (status != false) {
      status = true;
      _firestore.collection("locations").add({
        "coordinates": {"latitude": lat, "longitude": lng},
        "name": _Locationname,
        "userid": uid,
        "country": placemarks[0].isoCountryCode!.toLowerCase()
      });
    }

    print(status);
    return status;
  }

  Future update_Data(
      dynamic _Locationname, dynamic fname, dynamic lat, dynamic lng) async {
    User? usr = await _auth.currentUser;
    // print(usr?.uid);
    dynamic uid = usr?.uid;

    dynamic status;
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    await _firestore.collection("locations").get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        if (element.data()["name"] == _Locationname &&
            element.data()["userid"] == uid) {
          print(element.data()["name"]);
          status = false;
        }
      });
    });

    print("Status_value:  ${status}");
    if (status != false) {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      await _firestore.collection("locations").get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          if (element.data()["userid"] == uid) {
           if (element.data()["name"] == fname) {
              print(element.data()["name"]);
              print(element.id);
              _firestore.collection("locations").doc(element.id).update({
                "coordinates": {"latitude": lat, "longitude": lng},
                "name": _Locationname,
                "userid": uid,
                "country": placemarks[0].isoCountryCode!.toLowerCase()
              });
              status = true;
              // _firestore.collection("locations").add({"coordinates":{"latitude":lat,"longitude":lng},"name":_Locationname,"userid":uid});
            }
          }
        });
      });
    }

    print("Update_status : ${status}");
    return status;
  }

  Future deleteData(dynamic _Locationname) async {
    User? usr = await _auth.currentUser;
    // print(usr?.uid);
    dynamic uid = usr?.uid;

    dynamic status;

    await _firestore.collection("locations").get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        print(element.data());
        if (element.data()["userid"] == uid) {
          if (element.data()["name"] == _Locationname) {
            print(element.data()["name"]);
            print(element.id);
            _firestore.collection("locations").doc(element.id).delete();
            status = true;
            // _firestore.collection("locations").add({"coordinates":{"latitude":lat,"longitude":lng},"name":_Locationname,"userid":uid});
          }
        }
      });
    });

    print(status);
    return status;
  }

  Future getLists() async {
    List _list = [];

    await _firestore.collection("locations").get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        print(element.data()["name"]);
        _list.add(element.data()["name"]);
      });
    });

    // print(_list);
    return (_list);
  }
}
