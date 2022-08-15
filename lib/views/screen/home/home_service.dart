import 'package:ecome_app/views/screen/widget/appversion/app_version.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode_full/jwt_decode_full.dart';
import 'package:provider/provider.dart';

import 'package:ecome_app/provider/user_provider.dart';
import 'package:ecome_app/controllers/main_service.dart';

class HomeService {
  final mainService = MainService();
  var randomColor;

  getProfile(BuildContext context) async {
    var url = await mainService.urlApi() + '/api/v1/user/profile';

    mainService.getUrl(url, (res) async {
      if (res.statusCode == 200) {
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(res.body);
        randomColor = await mainService.getRandomColor();
        mainService.saveStorage('AU@HZS!', res.body);
      } else {
        mainService.errorHandling(res, context);
      }
    });
  }

  checkAppVersion(BuildContext context) async {
    final token = await mainService.getAccessToken();
    final decodeToken = jwtDecode(token);
    print(decodeToken.payload['latestApkVersion']);
    if (decodeToken.payload['latestApkVersion'] != '1.1.3') {
      showDialog(
          context: context,
          builder: (context) {
            return AppVersion();
          });
    }
  }
}
