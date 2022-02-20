import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shopping_mall/views/basket_list_view.dart';

import '../controllers/provider_class_sepet.dart';
import '../data/models/ProductFromAPI.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail(
      {Key? key, required this.productFromApi, required this.controller})
      : super(key: key);

  final ProductFromApi productFromApi;

  final ScrollController controller;

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    BasketProvider sepetProvider = Provider.of<BasketProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ListView(
          controller: widget.controller,
          children: [
            /// Image
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Container(
                width: size.width * 0.7,
                height: size.height * 0.3,
                child: Image.network('${widget.productFromApi.image}'),
              ),
            ),

            /// Product Name and Rating
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 0.2,
                    spreadRadius: 0.0,
                    offset: Offset(0.3, 0.0), // shadow direction: bottom right
                  )
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.productFromApi.title}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Text('Rating: '),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.green),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                '${widget.productFromApi.rating.rate}',
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            /// Product Information
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 0.2,
                    spreadRadius: 0.0,
                    offset: Offset(0.3, 0.0), // shadow direction: bottom right
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Product Information',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${widget.productFromApi.description}',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 0.5,
                spreadRadius: 0.0,
                offset: Offset(0.7, 0.0), // shadow direction: bottom right
              )
            ],
          ),
          child: Card(
            child: ListTile(
              leading: Text(
                '${widget.productFromApi.price} TL',
                style: TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  sepetProvider.addList(widget.productFromApi);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyShoppingList()));
                },
                child: Text("Add To Basket"),
                style: ElevatedButton.styleFrom(
                    elevation: 7,
                    primary: HexColor("#29cc81"),
                    fixedSize: Size(220, 45),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
