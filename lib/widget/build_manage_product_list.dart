import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_labor/pages/edit_product_page.dart';
import 'package:shop_labor/provider/Products.dart';

class Build_manage_Product_list extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

      return  Consumer<Products>(
      builder: (_, products, __) => Expanded(
    child: ListView.builder(
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return Card(
          child: ListTile(
            leading: CachedNetworkImage(
              imageUrl: products.product_list.elementAt(index).image,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red,),
            ),
            title: Text(
                products.product_list
                    .elementAt(index)
                    .product_name),
            trailing: Container(
              width: 100,
              child: Row(

                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () =>
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                Edit_product_page(
                                    products.product_list.elementAt(index), index))),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => products.remove_product_from_product_list(index),
                  ),

                ],
              ),
            ),
          ),
        );
      },
      itemCount: products.product_list.length,
    ),
    ));


  }
}
