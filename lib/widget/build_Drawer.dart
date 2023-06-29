import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Build_Drawer {
  Widget shop_drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.shop),
            title: const Text('Products'),
            onTap: () {
              Navigator.pushNamed(context, '/show_home_page');
            },
          ),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: const Text('Orders'),
            onTap: () {
              Navigator.pushNamed(context, '/show_orders');
            },
          ),
          ListTile(
            leading: Icon(Icons.build),
            title: const Text('Manage Products'),
            onTap: () {
              Navigator.pushNamed(context, '/show_manage_product_page');
            },
          ),
        ],
      ),
    );
  }
}
