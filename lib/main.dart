
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_labor/pages/MyHomePage.dart';

import 'package:shop_labor/pages/manage_product_page.dart';
import 'package:shop_labor/pages/order_page.dart';
import 'package:shop_labor/pages/show_shopping_cart.dart';
import 'package:shop_labor/provider/Products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Products>(
      create: (context) => Products(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lern App',
        routes: <String, WidgetBuilder>{
          '/show_manage_product_page': (context) => Manage_product_page(),
         // '/show_available_products': (context) => Show_available_products(),
          '/show_shopping_cart': (context) => Show_shopping_cart(),
          '/show_orders': (context) => Order_page(),
          '/show_home_page': (context) => MyHomePage(title: 'My Products',),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  const MyHomePage(title: 'My products'),
      ),
    );
  }
}



