import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecome_app/controllers/main_service.dart';
import 'package:ecome_app/views/screen/widget/category_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Category extends StatefulWidget {
  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  // const Category({Key? key}) : super(key: key);
  final mainService = MainService();
  List<dynamic> news = [];

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    var url = await mainService.urlApi() + '/api/v1/newsfeed?active=true';

    await mainService.getUrl(url, (res) {
      if (res.statusCode == 200) {
        setState(() {
          Map<String, dynamic> resData = jsonDecode(res.body);
          news = resData['content'];
        });
      } else {
        mainService.errorHandling(res, context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      child: news.length > 0
          ? CarouselSlider.builder(
              options: CarouselOptions(
                  height: 200, autoPlay: true, viewportFraction: 1),
              itemCount: news.length,
              itemBuilder: (context, int index, realIndex) {
                return CategoryItem(
                  index: index,
                  data: news,
                );
              },
            )
          : Container(),
    );
  }
}
