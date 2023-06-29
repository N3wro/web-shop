import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_labor/domain/orders.dart';
import 'package:shop_labor/domain/product.dart';
import 'package:shop_labor/provider/Products.dart';

class Build_order_details extends StatelessWidget{


  Order curr_order;


  Build_order_details(this.curr_order);

  @override
  Widget build(BuildContext context) {

     return

           ListView.builder(
            shrinkWrap: true,

            scrollDirection: Axis.vertical,

            itemBuilder: (_, index) {

              return Card(
                child: ListTile(

                  leading: Text('${(curr_order.products).keys.elementAt(index).product_name}'),
                  trailing: Text('${curr_order.products.values.elementAt(index)} x ${curr_order.products.keys.elementAt(index).price}'),
                ),
              );

            },
            itemCount:  curr_order.products.length,

        );

  }

}