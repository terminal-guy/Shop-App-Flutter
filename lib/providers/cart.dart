import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  // * NOTES
  // Returning in Map cuz we will check with the productId with the cartitem id.

  Map<String, CartItem> get items {
    return {..._items};
  } // getter for _items.

  int get itemCount {
    return _items.length;
  }

  // Getting the totalamount by cartItem price multiplied with cartitem quantity.
  // And we are looping with for each element in the map

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    // * NOTES
    // checking key that if it has the key.
    // For replacing the quantity.
    // adding have the existingcartitem
    // But adding existingCartItemQuantity with plus one.
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      // *NOTES
      // if the if check failed checking if put if absent with productid
      // the default quantity as 1
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
