import 'package:badges/badges.dart';
import 'package:ecome_app/models/products.dart';
import 'package:ecome_app/provider/products.dart';
import 'package:ecome_app/views/screen/detail/detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class FeedsProducts extends StatefulWidget {
  @override
  State<FeedsProducts> createState() => _FeedsProductsState();
}

class _FeedsProductsState extends State<FeedsProducts> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Product>(context);

    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(DetailPage.id, arguments: products.id);
        },
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
                          products.imageUrl,
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned(
                    child: Badge(
                      toAnimate: true,
                      shape: BadgeShape.square,
                      badgeColor: Colors.pink,
                      borderRadius: BorderRadius.circular(8),
                      badgeContent:
                          Text('New ', style: TextStyle(color: Colors.white)),
                    ),
                    left: 5,
                    top: 15,
                  )
                ],
              ),
              Text(
                products.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
              Text(
                '\$ ${products.price}',
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
