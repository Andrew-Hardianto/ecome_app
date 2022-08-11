import 'package:ecome_app/models/map.dart';
import 'package:flutter/material.dart';

class MapProvider extends ChangeNotifier {
  OfficeLocation _officeLocation = OfficeLocation(
    officeLatitude: 0.0,
    officeLongitude: 0.0,
    toleranceInMeter: 0,
  );

  OfficeLocation get officeLocation => _officeLocation;

  void setOfficeLocation(String officeLocation) {
    _officeLocation = OfficeLocation.fromJson(officeLocation);
    notifyListeners();
  }

  void setOfficeLocationFromModel(OfficeLocation officeLocation) {
    _officeLocation = officeLocation;
    notifyListeners();
  }
}
