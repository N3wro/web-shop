import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_labor/domain/product.dart';
import 'package:shop_labor/provider/Products.dart';

class Edit_product_page extends StatelessWidget {
  Product product;
  int index;
  Product new_product =
      Product('https://i.imgflip.com/2mwc77.jpg', 0.0, '', '');

  Edit_product_page(this.product, this.index);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    new_product = product;
    return Scaffold(
      appBar: AppBar(
        title: Text("edit prodcut"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Provider.of<Products>(context, listen: false)
                    .replace_or_add_product_from_product_list(
                        new_product, index);
                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextFormField(
                      controller: TextEditingController(
                          text: "${product.product_name}"),
                      decoration: const InputDecoration(
                        hintText: 'insert product name',
                        labelText: 'Title',
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else {
                          new_product.product_name = value;
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller:
                          TextEditingController(text: "${product.price}"),
                      decoration: const InputDecoration(
                        hintText: 'insert product price',
                        labelText: 'Price',
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some numbers';
                        } else if (double.parse(value) <= 0.0) {
                          return 'Please enter a valid value';
                        } else {
                          new_product.price = double.parse(value);
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextFormField(
                      controller:
                          TextEditingController(text: "${product.description}"),
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: 'insert product description',
                        labelText: 'Description',
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else {
                          new_product.description = value;
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Row(
                      children: [
                        Container(
                            height: 100,
                            width: 100,
                            child: CachedNetworkImage(
                              imageUrl: product.image,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Text("enter URL"),
                            )),
                        Container(
                          height: 100,
                          width: 300,
                          child: TextFormField(
                            controller:
                                TextEditingController(text: "${product.image}"),
                            maxLines: 10,
                            decoration: const InputDecoration(
                              hintText: 'insert product Image URL',
                              labelText: 'Image URL',
                            ),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              } else {
                                new_product.image = value;
                              }

                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
