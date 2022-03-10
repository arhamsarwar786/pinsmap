import 'package:location/location.dart';
class checkPermissions {
  final Location location = Location.instance;

  Future checkforPermissions() async{
    final _permissionGranted = await location.hasPermission();
    if(_permissionGranted == PermissionStatus.denied){
      return false;      
    }else{
      return true;
    }
  }

  Future checkForServices() async {    
    final _serviceEnabled = await location.serviceEnabled();
    if(!_serviceEnabled){
      final serviceEnabled = await location.requestService();
      if(!_serviceEnabled){
        return false;
      }else{
        return true;
      }
    }else{
      return true;
    }
  }

  Future askForPermissions() async {
    final _permissionGranted = await location.hasPermission();
    if(_permissionGranted == PermissionStatus.denied){
      print("doesn't existe");
      final permissionGranted = await location.requestPermission();
      if(_permissionGranted != PermissionStatus.granted){
        print("denied");
        return false;
      }else{
        print("granted");
        return true;
      }
    }else{
      print("alredy");
      return true;
    }
  }

}
