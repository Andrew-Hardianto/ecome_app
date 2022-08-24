import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CategoryItem extends StatefulWidget {
  final int index;
  final List<dynamic> data;

  CategoryItem({
    Key? key,
    required this.index,
    required this.data,
  }) : super(key: key);

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  List<Map<String, Object>> categories = [
    {
      'categoryName': 'Phones',
      'categoryImage': 'assets/images/CatPhones.png',
    },
    {
      'categoryName': 'Clothes',
      'categoryImage': 'assets/images/CatClothes.jpg',
    },
    {
      'categoryName': 'Laptop',
      'categoryImage': 'assets/images/CatLaptops.png',
    },
    {
      'categoryName': 'Shoes',
      'categoryImage': 'assets/images/CatShoes.jpg',
    },
    {
      'categoryName': 'Watch',
      'categoryImage': 'assets/images/CatWatches.jpg',
    },
  ];

  openNews(url) async {
    if (url != null) {
      var newsurl = Uri.parse(url);
      if (await canLaunchUrl(newsurl)) {
        await launch(
          url,
          forceWebView: true,
          forceSafariVC: true,
          enableJavaScript: true,
        );
        // await launchUrl(url,)
      }
    }
    print(url);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 5,
          ),
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage('${widget.data[widget.index]['imagePath']}'),
            ),
          ),
          child: InkWell(
            onTap: () {
              openNews(widget.data[widget.index]['url']);
            },
          ),
        ),
      ],
    );
  }
}
