import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../controllers/MaterialProvider.dart';
import '../controllers/provider_class.dart';
import '../controllers/provider_class_sepet.dart';
import '../data/models/ProductFromAPI.dart';
import '../widgets/popular_products.dart';
import '../widgets/products.dart';

class Store extends StatefulWidget {
  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  int selectedCategory = 0;
  bool isFiltering = false;
  List<ProductFromApi> newList_Filtered = []; // filtrelenmiş liste

  Category? selectedType;

  bool isCategory = false;

  Map<String, Category>? products = categoryValues.map;

  @override
  Widget build(BuildContext context) {
    MaterialProvider themeDataButton = Provider.of<MaterialProvider>(context);

    ShoppingProvider magazaShopping = Provider.of<ShoppingProvider>(context);
    List<ProductFromApi> fullList = magazaShopping.magaza;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              themeDataButton.toggleStatus();
            },
            icon: Icon(
              Icons.lightbulb,
              color: Colors.orange,
            )),
        actions: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 10, 20, 10),
            child: TextField(
              onChanged: (query) {
                if (query.isNotEmpty) {
                  isFiltering = true;

                  setState(() {
                    newList_Filtered = fullList
                        .where((product) => product.title
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                        .toList();
                  });
                } else {
                  WidgetsBinding.instance!.focusManager.primaryFocus!.unfocus();
                  setState(() {
                    isFiltering = false;
                  });
                }
              },
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                prefixIcon: Icon(Icons.search),
                hintText: "Arama: Product Name ",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
              ),
            ),
          )),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
              color: Colors.blueGrey[900],
              height: 70,
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: products!.values.map((values) {
                  String name = values.name.toLowerCase().trim();
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: () {
                          isCategory = true;
                          setState(() {
                            selectedType = values;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$name',
                              style: TextStyle(
                                  color: selectedType == values
                                      ? Colors.deepOrange
                                      : Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 2,
                              width: 30,
                              color: selectedType == values
                                  ? Colors.deepOrange
                                  : Colors.white,
                            )
                          ],
                        )),
                  );
                }).toList()),
              )),
          Flexible(
            flex: 2,
            child: PopularProducts(),
          ),
          magazaShopping.magaza.isNotEmpty
              ? Flexible(
                  flex: 5,
                  child: Consumer2<ShoppingProvider, BasketProvider>(
                    builder:
                        (context, shoppingProvider, basketProvider, child) {
                      return GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 0.6),
                          children: isFiltering
                              ? newList_Filtered
                                  .where((element) => isCategory
                                      ? element.category == selectedType
                                      : element == element)
                                  .map(
                                  (productDataList) {
                                    return ProductsList(
                                        productDataList: productDataList,
                                        basketProvider: basketProvider);

                                    // buildProduct(context,
                                    //   productDataList, basketProvider);
                                  },
                                ).toList()
                              : shoppingProvider.magaza
                                  .where((element) => isCategory
                                      ? element.category == selectedType
                                      : element == element)
                                  .map(
                                  (productDataList) {
                                    return ProductsList(
                                        productDataList: productDataList,
                                        basketProvider: basketProvider);

                                    //
                                    // buildProduct(context,
                                    //   productDataList, basketProvider);
                                  },
                                ).toList());
                    },
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ],
      ),
    );
  }
}
