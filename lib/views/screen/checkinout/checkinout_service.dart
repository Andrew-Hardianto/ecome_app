import 'dart:convert';
// import 'dart:html';
// import 'dart:html';

import 'package:ecome_app/controllers/main_service.dart';
import 'package:ecome_app/models/user.dart';
import 'package:ecome_app/provider/map_provider.dart';
import 'package:ecome_app/provider/user_provider.dart';
import 'package:ecome_app/views/screen/bottom_navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckInOutService {
  final mainService = MainService();

  getLocation(BuildContext context) async {
    final url = await mainService.urlApi() + '/api/v1/user/location';

    mainService.getUrl(url, (res) {
      if (res.statusCode == 200) {
        var officeLocation = Provider.of<MapProvider>(context, listen: false);
        officeLocation.setOfficeLocation(res.body);
      } else {
        mainService.errorHandling(res, context);
      }
    });
  }

  getPurpose(BuildContext context) async {
    final url = await mainService.urlApi() +
        '/api/v1/lookup/globalkey?name=TM_CHECKINOUT_PURPOSES';

    final List<PurposeCheckInOut> purposeList = [];
    // final purposeList = Provider.of<UserProvider>(context);

    await mainService.getUrl(url, (res) {
      if (res.statusCode == 200) {
        List<dynamic> resData = jsonDecode(res.body);
        resData.forEach((data) {
          purposeList.add(
            PurposeCheckInOut(
              description: data['description'],
              name: data['name'],
              value: data['value'],
            ),
          );
        });
        // return purposeList;
      } else {
        mainService.errorHandling(res, context);
      }
    });
  }

  submitCheckinout(BuildContext context, data) async {
    final url = await mainService.urlApi() + '/api/v1/user/tm/checkinout';

    var form = {'checkinout': jsonEncode(data)};

    await mainService.postUrlApi(url, form, (res) {
      if (res.statusCode == 200) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => BottomNavbar()));
      } else {
        mainService.errorHandling(res, context);
      }
    });
  }
}
