import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../controllers/provider_class_sepet.dart';
import '../data/models/ProductFromAPI.dart';
import 'body.dart';

class MyShoppingList extends StatefulWidget {
  @override
  State<MyShoppingList> createState() => _MyShoppingListState();
}

class _MyShoppingListState extends State<MyShoppingList> {
  @override
  Widget build(BuildContext context) {
    BasketProvider basketProvider = Provider.of<BasketProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        elevation: 0,
        title: Text("My List "),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                basketProvider.clear1(basketProvider.sepet);
              },
              icon: Icon(Icons.remove_shopping_cart_rounded))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Consumer<BasketProvider>(
                builder: (context, shoppingProvider, child) {
              List<ProductFromApi> distinctIds =
                  shoppingProvider.sepet.toSet().toList();
              return ListView.builder(
                itemCount: distinctIds.length,
                itemBuilder: (context, index) {
                  ProductFromApi basketList = distinctIds[index];

                  return Card(
                    child: Column(
                      children: [
                        Container(
                            width: 120,
                            height: 120,
                            child: Image.network('${basketList.image}')),
                        ListTile(
                          trailing: Container(
                            width: 120,
                            height: 80,
                            child: Row(
                              children: [
                                Flexible(
                                  child: basketList.initialCount > 1
                                      ? IconButton(
                                          onPressed: () {
                                            basketProvider
                                                .removeList(basketList);
                                          },
                                          icon: Icon(
                                            Icons.remove,
                                            color: Colors.green,
                                          ),
                                        )
                                      : basketList.initialCount == 1
                                          ? IconButton(
                                              onPressed: () {
                                                basketProvider
                                                    .removeList(basketList);
                                                print(basketList.price);
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            )
                                          : Container(),
                                ),
                                Container(
                                  width: 18,
                                  height: 30,
                                  alignment: Alignment.center,
                                  child: Text('${basketList.initialCount}'),
                                ),
                                Flexible(
                                  child: IconButton(
                                    onPressed: () {
                                      basketProvider.addList(basketList);
                                    },
                                    ////github deneme
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          title: Text("${basketList.title}"),
                          subtitle: Text("Total Price : ${basketList.price}"),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
          Card(
            elevation: 10,
            shadowColor: Colors.black,
            child: ListTile(
              title: Text(
                'Total Price: ${basketProvider.totalPrice.abs().toStringAsFixed(2)}',
                style: TextStyle(color: HexColor("#fa0050")),
              ),
              trailing: ElevatedButton(
                onPressed: () {},
                child: Text("Confirm Card"),
                style: ElevatedButton.styleFrom(
                    elevation: 7,
                    primary: HexColor("#29cc81"),
                    fixedSize: Size(220, 45),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
