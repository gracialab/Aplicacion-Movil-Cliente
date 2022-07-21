import 'package:geocoding/geocoding.dart';

class GeocodeComponent {
  Future<String> address(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      return '${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].country} ';
    } catch (e) {
      print(e);
      return 'Colombia';
    }
  }
}
