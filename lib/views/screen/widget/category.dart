import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecome_app/views/screen/widget/category_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Category extends StatelessWidget {
  // const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      child: CarouselSlider.builder(
        options:
            CarouselOptions(height: 200, autoPlay: true, viewportFraction: 1),
        itemCount: 5,
        itemBuilder: (context, int index, realIndex) {
          return CategoryItem(index: index);
        },
      ),
    );
  }
}
