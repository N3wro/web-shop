import 'package:flutter/material.dart';

class Product with ChangeNotifier implements Comparable  {

  String _image;
  double _price;
  String _product_name;
  String _description;
  bool is_favorite;

  Product(this._image, this._price, this._product_name, this._description, {this.is_favorite=false});

  @override
  int compareTo(other) {

    return this.compareTo(other);
  }


  String get image => _image;

  toggleFavorite()
  {
    is_favorite=!is_favorite;
    notifyListeners();
  }

  double get price => _price;

  String get product_name => _product_name;

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  set product_name(String value) {
    _product_name = value;
  }

  set price(double value) {
    _price = value;
  }

  set image(String value) {
    _image = value;
  }
}