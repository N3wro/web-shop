import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_labor/domain/product.dart';
import 'package:shop_labor/provider/Products.dart';

class Detail_page extends StatelessWidget {
  int _index;
  List<Product> _product_list;


  Detail_page(this._index, this._product_list);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context, listen: false);

    return Scaffold(
      appBar: new AppBar(
          title: Text(_product_list.elementAt(_index).product_name)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
            child: Container(
                child: CachedNetworkImage(
              imageUrl: _product_list.elementAt(_index).image,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(
                Icons.error,
                color: Colors.red,
              ),
              fit: BoxFit.cover,
              width: 600,
              height: 300,
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _product_list.elementAt(_index).product_name,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(_product_list.elementAt(_index).description),
          ),
        ],
      ),
    );
  }
}
