import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../controllers/provider_class_sepet.dart';
import '../data/models/ProductFromAPI.dart';
import '../views/constants/rating.dart';
import '../views/product_detail.dart';

class ProductsList extends StatelessWidget {
  const ProductsList(
      {Key? key, required this.productDataList, required this.basketProvider})
      : super(key: key);

  final ProductFromApi productDataList;
  final BasketProvider basketProvider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        buildShowModalBottomSheet(context, productDataList);
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  child: Image.network('${productDataList.image}'),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Text(
                    '${productDataList.title}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 15),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            RatingStars(
                              productFromApi: productDataList,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 7),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: HexColor("#29cc81")),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      '${productDataList.rating.rate}',
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),

                      Text(
                        'Price: ${productDataList.price}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: HexColor("#29cc81")),
                      ),
                      // Text(
                      //     'remainingItem: ${productDataList.rating.count}'),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: productDataList.initialCount == 0
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 7,
                            primary: HexColor("#29cc81"),
                            fixedSize: Size(220, 45),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        onPressed: () {
                          basketProvider.addList(productDataList);
                        },
                        child: Text('Add To Basket'))
                    : productDataList.initialCount == 1
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: HexColor("#29cc81"),
                                  blurRadius: 0.5,
                                  spreadRadius: 0.5,
                                  offset: Offset(0.5,
                                      0.5), // shadow direction: bottom right
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    basketProvider.removeList(productDataList);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                  ),
                                  color: Colors.red,
                                ),
                                Text('${productDataList.initialCount}'),
                                IconButton(
                                    onPressed: () {
                                      basketProvider.addList(productDataList);
                                    },
                                    icon: Icon(
                                      Icons.add,
                                    ),
                                    color: HexColor("#29cc81")),
                              ],
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: HexColor("#29cc81"),
                                  blurRadius: 0.5,
                                  spreadRadius: 0.5,
                                  offset: Offset(0.5,
                                      0.5), // shadow direction: bottom right
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    basketProvider.removeList(productDataList);
                                  },
                                  icon: Icon(
                                    Icons.remove,
                                  ),
                                  color: HexColor("#29cc81"),
                                ),
                                Text('${productDataList.initialCount}'),
                                IconButton(
                                    onPressed: () {
                                      basketProvider.addList(productDataList);
                                    },
                                    icon: Icon(
                                      Icons.add,
                                    ),
                                    color: HexColor("#29cc81")),
                              ],
                            ),
                          ))
          ],
        ),
      ),
    );
  }

  Future<dynamic> buildShowModalBottomSheet(
      BuildContext context, ProductFromApi productDataList) {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => DraggableScrollableSheet(
              initialChildSize: 0.7,
              minChildSize: 0.5,
              maxChildSize: 1,
              builder: (_, controller) => Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                child: ProductDetail(
                  productFromApi: productDataList,
                  controller: controller,
                ),
              ),
            ));
  }
}
