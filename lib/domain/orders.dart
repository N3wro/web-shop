import 'package:shop_labor/domain/product.dart';

class Order {

  Map<Product, int> _products;
  DateTime _dateTimeOrder;
  double _full_price =0;
  bool isExpanded = false;

  Order(this._products, this._dateTimeOrder, this._full_price);

  DateTime get dateTimeOrder => _dateTimeOrder;


  double get full_price => _full_price;

  Map<Product, int> get products => _products;

}