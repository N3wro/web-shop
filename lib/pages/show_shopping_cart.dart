import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:shop_labor/domain/orders.dart';
import 'package:shop_labor/domain/product.dart';
import 'package:shop_labor/provider/Products.dart';

class Show_shopping_cart extends StatefulWidget {
  @override
  State<Show_shopping_cart> createState() => _Show_shopping_cartState();
}

class _Show_shopping_cartState extends State<Show_shopping_cart> {
  double get_full_price(Map<Product, int> products) {
    double full_price = 0.0;

    for (int i = 0; i < products.length; i++) {
      full_price +=
          products.keys.elementAt(i).price * products.values.elementAt(i);
    }

    return full_price;
  }

  showAlertDialog(BuildContext context, Product deleted_product) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        setState(() {
          Provider.of<Products>(context, listen: false)
              .add_product_to_shopping_cart(deleted_product);

          Navigator.pop(context);
        });
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Deletion"),
      content: Text("Do you really want to delete this item?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog

    //Damit der Alert nicht auf der HomePage popt gibt es ein kurzes Delay
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final shopping_cart =
        Provider.of<Products>(context, listen: false).shopping_cart;

    double full_price = get_full_price(shopping_cart);

    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: Column(
        children: [
          Card(
            child: ListTile(
              leading: Text("Total"),
              trailing: SizedBox(
                height: 300,
                width: 150,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Container(
                        color: Colors.indigo,
                        child: Text(
                          "€ ${full_price}",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          if (full_price != 0) {
                            Provider.of<Products>(context, listen: false)
                                .addOrder(Order(

                                   new Map<Product, int>.from(shopping_cart),
                                    DateTime.now(),
                                    full_price));
                            Provider.of<Products>(context, listen: false)
                                .clear_shopping_cart();
                            Provider.of<Products>(context, listen: false)
                                .counter_for_badge = 0;
                          }
                        });
                      },
                      child: Text(
                        "Order Now",
                        style: TextStyle(color: Colors.indigo),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return Dismissible(
                direction: DismissDirection.endToStart,
                background: Card(
                  color: Colors.red,
                  child: ListTile(
                    trailing: Icon(
                      Icons.delete,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                key: Key(shopping_cart.keys.elementAt(index).product_name),
                onDismissed: (direction) {
                  Product deleted_product = shopping_cart.keys.elementAt(index);
                  setState(() {
                    shopping_cart.remove(shopping_cart.keys.elementAt(index));
                    Provider.of<Products>(context, listen: false)
                        .decrement_counter_badge();
                    showAlertDialog(context, deleted_product);
                  });
                },
                child: Card(
                  child: ListTile(
                    leading: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.indigo,
                      ),
                      width: 50,
                      child: Center(
                        child: Text(
                          "${shopping_cart.keys.elementAt(index).price}€",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    title:
                        Text(shopping_cart.keys.elementAt(index).product_name),
                    subtitle: Text(
                        "Total:€${shopping_cart.keys.elementAt(index).price * shopping_cart.values.elementAt(index)}"),
                    trailing: Text("${shopping_cart.values.elementAt(index)}"),
                  ),
                ),
              );
            },
            itemCount: shopping_cart.length,
          )
        ],
      ),
    );
  }
}
