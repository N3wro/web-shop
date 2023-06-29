import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_labor/domain/orders.dart';
import 'package:shop_labor/provider/Products.dart';
import 'package:shop_labor/widget/build_Drawer.dart';
import 'package:shop_labor/widget/build_order_details.dart';

class Order_page extends StatefulWidget
{
  @override
  State<Order_page> createState() => _Order_pageState();
}

class _Order_pageState extends State<Order_page> {


  int counter=0;
  @override
  Widget build(BuildContext context) {

     List<Order> orderList = Provider.of<Products>(context).order_list;


    return Scaffold(
      appBar: new AppBar(title: Text("Orders"),),

      drawer: Build_Drawer().shop_drawer(context),
      body:
           Column(
             children: [
               ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    orderList.elementAt(index).isExpanded = !isExpanded;

                  });
                },

                children: orderList.map<ExpansionPanel>((Order item) {
                  return ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text('€${item.full_price}'),
                        subtitle: Text('${item.dateTimeOrder.year}-${item.dateTimeOrder.month}-${item.dateTimeOrder.day}   ${item.dateTimeOrder.hour}:${item.dateTimeOrder.minute} '),
                      );
                    },
                    body:
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //damit die innere ListView ins ExpansionPanel passt
                            Flexible(
                                fit: FlexFit.loose,
                                child: Build_order_details(item)),
                            ],
                        ),


                    isExpanded: item.isExpanded,
                  );
                }).toList(),

          ),
             ],
           ),


    );
  }
}