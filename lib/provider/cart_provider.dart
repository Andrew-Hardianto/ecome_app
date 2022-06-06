import 'package:ecome_app/models/cart_attr.dart';
import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartAttr> _cartItems = {};

  Map<String, CartAttr> get getCartItem {
    return {..._cartItems};
  }

  double get totalAmount {
    var total = 0.0;

    _cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });

    return total;
  }
}
