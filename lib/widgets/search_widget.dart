// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:shopping_mall/data/models/ProductFromAPI.dart';
//
// class SearchWidget extends StatefulWidget {
//
//
//    SearchWidget({Key? key,required this.newList_Filtered, required this.fullList,required this.isFiltering}) : super(key: key);
//
//   final List<ProductFromApi> fullList;
//     List<ProductFromApi> newList_Filtered;
//    bool isFiltering;
//
//   @override
//   State<SearchWidget> createState() => _SearchWidgetState();
// }
//
// class _SearchWidgetState extends State<SearchWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       onChanged: (query) {
//         if (query.isNotEmpty) {
//           widget.isFiltering = true;
//
//           setState(() {
//             widget.newList_Filtered = widget.fullList
//                 .where((product) => product.title
//                 .toLowerCase()
//                 .contains(query.toLowerCase()))
//                 .toList();
//           });
//         } else {
//           WidgetsBinding.instance!.focusManager.primaryFocus!.unfocus();
//           setState(() {
//             widget.isFiltering = false;
//           });
//         }
//       },
//       decoration: InputDecoration(
//         fillColor: Colors.white,
//         filled: true,
//         contentPadding: EdgeInsets.fromLTRB(0, 15, 0, 0),
//         prefixIcon: Icon(Icons.search),
//         hintText: "Arama: Product Name ",
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(
//             20,
//           ),
//         ),
//       ),
//     );
//   }
// }
