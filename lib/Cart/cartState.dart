import 'package:LaFoodie/Menu%20Screen/Data.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  final List<CartItem> cart = [];

  void addItemInToCart(Dishes dish,
      {int quantity = 1, @required BuildContext context}) {
    final isAlreadyInCart = cart
        .any((element) => element.dishesFirebase.key.compareTo(dish.key) == 0);

    ///update if item already in cart
    if (isAlreadyInCart == true) {
      final index = cart.indexWhere(
          (element) => element.dishesFirebase.key.compareTo(dish.key) == 0);

      cart[index].updateQuantity(quantity);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Item updated in cart")));

      notifyListeners();
    }

    ///add item if not in cart
    else {
      cart.add(CartItem(dish, quantity));
      print(
          "item with key ${dish.key} and price ${dish.price} is added in cart with quantity $quantity");

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Item added in cart")));

      notifyListeners();
    }
  }

  void removeItemFromTheCart(Dishes dish,
      {int quantity = 1, @required context}) {
    final isAlreadyInCart = cart
        .any((element) => element.dishesFirebase.key.compareTo(dish.key) == 0);

    assert(isAlreadyInCart != false, "Item not present in the cart");

    final index = cart.indexWhere(
        (element) => element.dishesFirebase.key.compareTo(dish.key) == 0);

    cart.removeAt(index);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Item removed from cart")));

    notifyListeners();
  }

  void increaseItemQuantityInTheCart(Dishes dish,
      {int quantity = 1, @required context}) {
    final isAlreadyInCart = cart
        .any((element) => element.dishesFirebase.key.compareTo(dish.key) == 0);

    assert(isAlreadyInCart != false, "Item not present in the cart");

    final index = cart.indexWhere(
        (element) => element.dishesFirebase.key.compareTo(dish.key) == 0);

    cart[index].increaseQuantity();

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Item updated in cart")));

    notifyListeners();
  }

  void decreaseItemQuantityInTheCart(Dishes dish,
      {int quantity = 1, @required context}) {
    final isAlreadyInCart = cart
        .any((element) => element.dishesFirebase.key.compareTo(dish.key) == 0);

    assert(isAlreadyInCart != false, "Item not present in the cart");

    final index = cart.indexWhere(
        (element) => element.dishesFirebase.key.compareTo(dish.key) == 0);

    cart[index].decreaseQuantity();

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Item updated in cart")));

    notifyListeners();
  }
}
