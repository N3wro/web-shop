import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_labor/domain/product.dart';
import 'package:shop_labor/provider/Products.dart';
import 'package:shop_labor/widget/build_manage_product_list.dart';

import 'edit_product_page.dart';

class Manage_product_page extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(title: Text('My Products'),
        actions: [
          IconButton(

              icon: Icon(Icons.add), onPressed: () {
                Navigator.push( context,
                    MaterialPageRoute(builder: (context) =>
                        Edit_product_page(
                            new Product('', 0.0,'',''), Provider.of<Products>(context).product_list.length+1)));
          },)
        ],
        ),

      body:  Column(
        children: [
          Build_manage_Product_list(),
        ],
      ),

    );
  }

}