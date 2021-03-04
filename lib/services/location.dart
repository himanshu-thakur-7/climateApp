import 'package:geolocator/geolocator.dart';
class Location{
  double longitude,latitude;
 Future<void>getCurrentLocation() async
  {
    try {
      Position pos = await Geolocator().getLastKnownPosition(
          desiredAccuracy: LocationAccuracy.low);
      longitude = pos.longitude;
      latitude = pos.latitude;

    }
    catch(e){
      print(e);
    }
  }
}