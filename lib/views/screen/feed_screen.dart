import 'package:ecome_app/models/products.dart';
import 'package:ecome_app/provider/products.dart';
import 'package:ecome_app/views/screen/widget/feeds_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);

    List<Product> productsList = productsProvider.products;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Feeds Products',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        childAspectRatio: 240 / 320,
        children: List.generate(
          productsList.length,
          (index) => ChangeNotifierProvider.value(
            value: productsList[index],
            child: FeedsProducts(),
          ),
        ),
      ),
    );
  }
}
