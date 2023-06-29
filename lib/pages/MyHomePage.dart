import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_labor/provider/Products.dart';
import 'package:shop_labor/widget/build_Drawer.dart';
import 'package:shop_labor/widget/build_grid_view.dart';

import '../main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Build_Drawer().shop_drawer(context),
        appBar: AppBar(

          title: Text("Products"),
          actions: [
            PopupMenuButton<String>(
                tooltip: 'view menu',
                onSelected: (item) {
                  setState(() {
                    switch (item) {
                      case 'show favourites':
                        Provider.of<Products>(context, listen: false).showFavourites =
                        true;
                        break;
                      case 'show all':
                        Provider.of<Products>(context, listen: false).showFavourites =
                        false;
                    }
                  });
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text("show favourites"),
                    value: 'show favourites',
                  ),
                  PopupMenuItem(
                    child: Text('show all'),
                    value: 'show all',
                  )
                ]),
            Badge(
              position: BadgePosition.topEnd(top: 10, end: 10),
              badgeContent: Text(
                '${Provider.of<Products>(context, listen: true).counter_for_badge}',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
              child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/show_shopping_cart');
                  },
                  icon: Icon(Icons.shopping_cart_rounded)),
            )
          ],
        ),
        body: Build_grid_view());
  }
}
