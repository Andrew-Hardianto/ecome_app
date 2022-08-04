import 'package:ecome_app/controllers/main_service.dart';
import 'package:ecome_app/models/clothes.dart';
import 'package:ecome_app/views/screen/widget/all_products.dart';
import 'package:ecome_app/views/screen/widget/category.dart';
import 'package:ecome_app/views/screen/widget/category_list.dart';
import 'package:ecome_app/views/screen/widget/custom_app_bar.dart';
import 'package:ecome_app/views/screen/widget/products.dart';
import 'package:ecome_app/views/screen/widget/searchbar.dart';
import 'package:ecome_app/views/screen/widget/tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreeen extends StatefulWidget {
  // const HomeScreeen({Key? key}) : super(key: key);
  @override
  State<HomeScreeen> createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<HomeScreeen> {
  var mainService = MainService();

  @override
  void initState() {
    super.initState();
    get();
  }

  get() async {
    print({'status': mainService.urlApi().toString()});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(),
            Searchbar(),
            TagList(),
            Category(),
            CategoryList(),
            AllProducts(),
          ],
        ),
      ),
    );
  }
}
