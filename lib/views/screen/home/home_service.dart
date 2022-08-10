import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecome_app/provider/user_provider.dart';
import 'package:ecome_app/controllers/main_service.dart';

class HomeService {
  final mainService = MainService();
  var randomColor;

  getProfile(BuildContext context) async {
    var url = await mainService.urlApi() + '/api/v1/user/profile';

    data(res) async {
      if (res.statusCode == 200) {
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(res.body);
        randomColor = await mainService.getRandomColor();
      } else {
        print(res.body['error_description']);
      }
    }

    mainService.getUrl(url, (res) => data(res));
  }
}
