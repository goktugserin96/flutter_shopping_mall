import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/provider_class.dart';
import '../controllers/provider_class_sepet.dart';
import '../data/models/ProductFromAPI.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BasketProvider basketProvider = Provider.of<BasketProvider>(context);
    ShoppingProvider magazaShopping = Provider.of<ShoppingProvider>(context);
    List<ProductFromApi> fullList = magazaShopping.magaza;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Popular Products',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: fullList
                .where((element) => element.rating.rate > 4.5)
                .map(
                  (popularProducts) =>
                      // ProductsList(
                      //         productDataList: popularProducts,
                      //         basketProvider: basketProvider)
                      Card(
                    child: Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          child: Image.network(
                            popularProducts.image,
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          child: Text(
                            popularProducts.title,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),

            // itemBuilder: (context, index) => Card(
            //       child: Center(child: Text('aaaa')),
            //     )
          ),
        ),
      ],
    );
  }
}
