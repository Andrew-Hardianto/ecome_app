import 'package:ecome_app/views/screen/widget/category_list.dart';
import 'package:ecome_app/views/screen/widget/custom_app_bar.dart';
import 'package:ecome_app/views/screen/widget/searchbar.dart';
import 'package:ecome_app/views/screen/widget/tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreeen extends StatelessWidget {
  const HomeScreeen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(),
          Searchbar(),
          TagList(),
          CategoryList(),
        ],
      ),
    );
  }
}
