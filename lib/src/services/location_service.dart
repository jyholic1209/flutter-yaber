import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationServices {
  LocationServices._internal();
  static final LocationServices _locationServices =
      LocationServices._internal();
  factory LocationServices() {
    return _locationServices;
  }

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  // Placemark address = Placemark();

  // GPS 퍼미션
  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    // GPS 서비스 체크
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // GPS 서비스가 안켜져 있으면
      return false;
    }
    // 퍼미션 체크
    permission = await _geolocatorPlatform.checkPermission();
    // 퍼미션이 없으면
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return false;
    }
    return true;
  }

  Future<List<Placemark>> getCurrentPosition() async {
    final hasPermission = await _handlePermission();
    if (!hasPermission) {
      return [];
    }

    var position = await _geolocatorPlatform.getCurrentPosition();
    // List[0]에 모두 한꺼번에 담김.
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    // Placemark 클래스에 담아줌.
    // address = placemarks.first;
    return placemarks;
  }
}
