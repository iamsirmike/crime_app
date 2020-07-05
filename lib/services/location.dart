import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;

  Future getUserLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    latitude = position.latitude;
    longitude = position.longitude;
    print(latitude);
  }
}
