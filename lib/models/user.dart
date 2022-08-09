import 'dart:convert';

import 'package:flutter/material.dart';

class User {
  final bool active;
  final String alias;
  final String assignmentId;
  final String authoritiesToken;
  final String companyId;
  final String companyName;
  final String companyPicture;
  final bool dailyMood;
  final String employeeId;
  final String employeeNo;
  final String employmentId;
  final String fullName;
  final bool haveAPin;
  final bool haveCheckIn;
  final bool isDailyMood;
  final bool isHaveAPin;
  final bool isOffShift;
  final String moodValue;
  final bool offShift;
  final String organizationName;
  final String packageName;
  final String positionName;
  final String profilePicture;
  final String shiftInDateTime;
  final String timezone;

  User({
    required this.active,
    required this.alias,
    required this.assignmentId,
    required this.authoritiesToken,
    required this.companyId,
    required this.companyName,
    required this.companyPicture,
    required this.dailyMood,
    required this.employeeId,
    required this.employeeNo,
    required this.employmentId,
    required this.fullName,
    required this.haveAPin,
    required this.haveCheckIn,
    required this.isDailyMood,
    required this.isHaveAPin,
    required this.isOffShift,
    required this.moodValue,
    required this.offShift,
    required this.organizationName,
    required this.packageName,
    required this.positionName,
    required this.profilePicture,
    required this.shiftInDateTime,
    required this.timezone,
  });

  Map<String, dynamic> toMap() {
    return {
      'active': active,
      'alias': alias,
      'assignmentId': assignmentId,
      'authoritiesToken': authoritiesToken,
      'companyId': companyId,
      'companyName': companyName,
      'companyPicture': companyPicture,
      'dailyMood': dailyMood,
      'employeeId': employeeId,
      'employeeNo': employeeNo,
      'employmentId': employmentId,
      'fullName': fullName,
      'haveAPin': haveAPin,
      'haveCheckIn': haveCheckIn,
      'isDailyMood': isDailyMood,
      'isHaveAPin': isHaveAPin,
      'isOffShift': isOffShift,
      'moodValue': moodValue,
      'offShift': offShift,
      'organizationName': organizationName,
      'packageName': packageName,
      'positionName': positionName,
      'profilePicture': profilePicture,
      'shiftInDateTime': shiftInDateTime,
      'timezone': timezone,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      active: map['active'] ?? false,
      alias: map['alias'] ?? '',
      assignmentId: map['assignmentId'] ?? '',
      authoritiesToken: map['authoritiesToken'] ?? '',
      companyId: map['companyId'] ?? '',
      companyName: map['companyName'] ?? '',
      companyPicture: map['companyPicture'] ?? '',
      dailyMood: map['dailyMood'] ?? false,
      employeeId: map['employeeId'] ?? '',
      employeeNo: map['employeeNo'] ?? '',
      employmentId: map['employmentId'] ?? '',
      fullName: map['fullName'] ?? '',
      haveAPin: map['haveAPin'] ?? false,
      haveCheckIn: map['haveCheckIn'] ?? false,
      isDailyMood: map['isDailyMood'] ?? false,
      isHaveAPin: map['isHaveAPin'] ?? false,
      isOffShift: map['isOffShift'] ?? false,
      moodValue: map['moodValue'] ?? '',
      offShift: map['offShift'] ?? false,
      organizationName: map['organizationName'] ?? '',
      packageName: map['packageName'] ?? '',
      positionName: map['positionName'] ?? '',
      profilePicture: map['profilePicture'] ?? '',
      shiftInDateTime: map['shiftInDateTime'] ?? '',
      timezone: map['timezone'] ?? '',
    );
  }

  String toJson() => jsonEncode(toMap());

  factory User.fromJson(String source) => User.fromMap(jsonDecode(source));
}

class ProfileSettingMenu {
  final Icon menuIcon;
  final String name;
  final String url;

  ProfileSettingMenu({
    required this.menuIcon,
    required this.name,
    required this.url,
  });
}
