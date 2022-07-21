import 'package:location/location.dart';

class LocationComponent {
  static Future<LocationData> get() async {
    Location location = Location();
    return await location.getLocation();
  }

  static Future<bool> requestPermission() async {
    Location location = Location();
    final PermissionStatus permissionStatus =
        await location.requestPermission();

    switch (permissionStatus) {
      case PermissionStatus.denied:
      case PermissionStatus.deniedForever:
        return false;
      default:
        return true;
    }
  }

  static Future<bool> validate() async {
    return await requestPermission();
  }
}
