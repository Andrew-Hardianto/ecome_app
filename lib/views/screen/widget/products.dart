import 'package:badges/badges.dart';
import 'package:ecome_app/models/clothes.dart';
import 'package:ecome_app/models/products.dart';
import 'package:ecome_app/provider/products.dart';
import 'package:ecome_app/views/screen/detail/detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final int index;

  const ProductItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _productsProvider = Provider.of<Products>(context);

    List<Product> _productsList = _productsProvider.products;

    return Container(
      margin: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {},
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    height: 170,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage(
                          _productsList[index].imageUrl,
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned(
                    child: Badge(
                      toAnimate: false,
                      shape: BadgeShape.square,
                      badgeColor: Colors.pink,
                      borderRadius: BorderRadius.circular(8),
                      badgeContent: Text('New Arrival',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    ),
                    left: 5,
                    top: 15,
                  )
                ],
              ),
              Text(
                _productsList[index].title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
              Text(
                '\$ ${_productsList[index].price}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1.6,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
