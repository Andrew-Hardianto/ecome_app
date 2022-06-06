import 'package:ecome_app/models/clothes.dart';
import 'package:ecome_app/models/products.dart';
import 'package:ecome_app/provider/products.dart';
import 'package:ecome_app/views/screen/widget/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class AllProducts extends StatelessWidget {
  final clotheList = Clothes.generateClothes();

  // const AllProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _productsProvider = Provider.of<Products>(context);

    List<Product> _productsList = _productsProvider.products;

    return Container(
      child: Column(
        children: [
          Container(
            height: 280,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => ProductItem(
                index: index,
              ),
              separatorBuilder: (_, index) => SizedBox(
                width: 8,
              ),
              itemCount: _productsList.length,
            ),
          )
        ],
      ),
    );
  }
}
