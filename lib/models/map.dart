import 'dart:convert';

class OfficeLocation {
  final double officeLatitude;
  final double officeLongitude;
  final num toleranceInMeter;

  const OfficeLocation({
    required this.officeLatitude,
    required this.officeLongitude,
    required this.toleranceInMeter,
  });

  Map<String, dynamic> toMap() {
    return {
      'officeLatitude': officeLatitude,
      'officeLongitude': officeLongitude,
      'toleranceInMeter': toleranceInMeter,
    };
  }

  factory OfficeLocation.fromMap(Map<String, dynamic> map) {
    return OfficeLocation(
      officeLatitude: map['officeLatitude'] != null
          ? map['officeLatitude'].toDouble()
          : 0.0,
      officeLongitude: map['officeLongitude'] != null
          ? map['officeLongitude'].toDouble()
          : 0.0,
      toleranceInMeter:
          map['toleranceInMeter'] != null ? map['toleranceInMeter'] : 0,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory OfficeLocation.fromJson(String source) =>
      OfficeLocation.fromMap(jsonDecode(source));
}

class UserLocation {
  final double userLatitude;
  final double userLongitude;

  const UserLocation({
    required this.userLatitude,
    required this.userLongitude,
  });
}
