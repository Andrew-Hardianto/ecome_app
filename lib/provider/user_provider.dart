import 'package:ecome_app/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    active: false,
    alias: '',
    assignmentId: '',
    authoritiesToken: '',
    companyId: '',
    companyName: '',
    companyPicture: '',
    dailyMood: false,
    employeeId: '',
    employeeNo: '',
    employmentId: '',
    fullName: '',
    haveAPin: false,
    haveCheckIn: false,
    isDailyMood: false,
    isHaveAPin: false,
    isOffShift: false,
    moodValue: '',
    offShift: false,
    organizationName: '',
    packageName: '',
    positionName: '',
    profilePicture: '',
    shiftInDateTime: '',
    timezone: '',
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
