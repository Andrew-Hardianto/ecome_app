import 'dart:convert';

import 'package:ecome_app/controllers/main_service.dart';
import 'package:ecome_app/provider/map_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CheckInOutService {
  final mainService = MainService();

  getLocation(BuildContext context) async {
    final url = await mainService.urlApi() + '/api/v1/user/location';

    mainService.getUrl(url, (res) {
      print(res.body);
      if (res.statusCode == 200) {
        var officeLocation = Provider.of<MapProvider>(context, listen: false);
        officeLocation.setOfficeLocation(res.body);
      } else {
        mainService.errorHandling(res, context);
      }
    });
  }
}
