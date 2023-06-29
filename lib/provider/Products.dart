import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:shop_labor/domain/orders.dart';
import 'package:shop_labor/domain/product.dart';
import 'package:sorted_list/sorted_list.dart';

class Products with ChangeNotifier {
  List<Product> product_list = [
    new Product('https://cdn-icons-png.flaticon.com/512/1311/1311144.png', 23.5,
        'product', 'desc 1'),
    new Product(
        'https://cdn.shopify.com/s/files/1/0536/4488/6197/products/ATATURKDuftbaum.Store_4_370x.png?v=1641464824',
        10,
        'product 2',
        'desc 2'),
    new Product(
        'https://upload.wikimedia.org/wikipedia/commons/8/8f/Game-Boy-Original.jpg',
        200,
        'product 3',
        'desc 3')
  ];
  Map<Product, int> shopping_cart = HashMap();
  List<Order> order_list =
      SortedList((a, b) => a.full_price.compareTo(b.full_price));

  bool showFavourites = false;
  int counter_for_badge = 0;

  increment_counter_badge() {
    counter_for_badge++;
    notifyListeners();
  }

  decrement_counter_badge() {
    counter_for_badge--;
    notifyListeners();
  }

  addOrder(Order order) {
    order_list.add(order);
  }

  addProduct(Product product) {
    product_list.add(product);
    notifyListeners();
  }

  editProduct(Product product, int index) {
    product_list.removeAt(index);
    product_list.insert(index, product);
    notifyListeners();
  }

  add_product_to_shopping_cart(Product product) {
    if (shopping_cart.containsKey(product)) {
      shopping_cart.addAll({product: shopping_cart[product]! + 1});
    } else {
      increment_counter_badge();
      shopping_cart.addAll({product: 1});
    }
    notifyListeners();
  }

  clear_shopping_cart() {
    shopping_cart.clear();
    notifyListeners();
  }

  remove_product_from_product_list(int index)
  {
    product_list.removeAt(index);
    notifyListeners();
  }

  toggleFavorite(Product product) {

    product.toggleFavorite();
    notifyListeners();
  }

  List<Product> getFavourite() {
    return product_list.where((element) => element.is_favorite).toList();
  }

  remove_products_from_shopping_cart(Product product, int index) {

    if (shopping_cart[product]==1)
      {
        shopping_cart.remove(product);
        decrement_counter_badge();
      }
    else
      {
        print(shopping_cart.toString());
        int? decrement=  shopping_cart[product];
        shopping_cart[product]=(decrement!-1);
      }

    notifyListeners();
  }



  replace_or_add_product_from_product_list(Product product, int index)
  {
    if (index <= product_list.length) {
      product_list.removeAt(index);

      product_list.insert(index, product);
    }
    else {
      product_list.add(product);
    }

    notifyListeners();
  }


}
