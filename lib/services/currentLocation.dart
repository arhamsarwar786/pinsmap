import 'package:location/location.dart';
class currentLocation {
  final Location location = Location.instance;

  Future getLocation() async {
    print(await location.getLocation().then((value) => {
      value.latitude,
    }));
  }
  Future<double> getLatitude() async{

    final val = await location.getLocation().then((value) => {
      "latitude": value.latitude
    });    
    double lat = double.parse(val["latitude"].toString());    
    return lat;
  }
  Future<double> getLongitude() async{
    final val = await location.getLocation().then((value) => {
      "longitude": value.longitude
    });    
    double long = double.parse(val["longitude"].toString());    
    return long;
  }
}