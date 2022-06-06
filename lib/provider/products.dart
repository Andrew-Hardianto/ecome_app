import 'package:ecome_app/models/products.dart';
import 'package:flutter/cupertino.dart';

class Products with ChangeNotifier {
  List<Product> _products = [
    Product(
      id: 'Sweater',
      title: 'Sweater',
      description: 'Sweater for kids',
      price: 70.99,
      imageUrl: 'assets/images/arrival1.png',
      productCategoryName: 'clothes',
      quantity: 10,
    ),
    Product(
      id: 'T-Shirt & Jacket',
      title: 'T-Shirt & Jacket',
      description: 'T-Shirt & Jacket for men',
      price: 80.99,
      imageUrl: 'assets/images/arrival2.png',
      productCategoryName: 'clothes',
      quantity: 10,
    ),
  ];

  List<Product> get products {
    return _products;
  }
}
