import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_labor/domain/product.dart';
import 'package:shop_labor/pages/detail_page.dart';
import 'package:shop_labor/provider/Products.dart';

class Build_grid_view extends StatefulWidget {
  @override
  State<Build_grid_view> createState() => _Build_grid_viewState();
}

class _Build_grid_viewState extends State<Build_grid_view> {


  @override
  Widget build(BuildContext context) {
    final filtered_product = Provider.of<Products>(context).showFavourites
        ? Provider.of<Products>(context).getFavourite()
        : Provider.of<Products>(context).product_list;

    return GridView.builder(
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (BuildContext context, int i) {
        return GridTile(
          //wenn man auf das Bild drückt
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => Detail_page(i ,filtered_product),
              ),
            ),
            child:CachedNetworkImage(
              imageUrl: filtered_product.elementAt(i).image,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red,),
              fit: BoxFit.cover,
              width: 30,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: Consumer<Products>(
              builder: (ctx, product, _) => IconButton(
                icon: Icon(
                  filtered_product.elementAt(i).is_favorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  setState(() {
                    Provider.of<Products>(context, listen: false)
                        .toggleFavorite(filtered_product.elementAt(i));
                  });
                },
              ),
            ),
            title: Text(
              filtered_product.elementAt(i).product_name,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {

                Provider.of<Products>(context, listen: false)
                    .add_product_to_shopping_cart(
                    filtered_product.elementAt(i));
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                final snackBar = SnackBar(
                  content: Text('${filtered_product.elementAt(i).product_name}  added'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {


                      // Some code to undo the change.
                      Provider.of<Products>(context, listen: false).remove_products_from_shopping_cart(filtered_product.elementAt(i), i);
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);


              },
              color: Theme.of(context).primaryColor,
            ),
          ),
        );
      },
      itemCount: filtered_product.length,
    );
  }
}
