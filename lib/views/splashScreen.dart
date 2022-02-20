// // import 'package:animated_splash_screen/animated_splash_screen.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:page_transition/page_transition.dart';
// // import 'package:provider/provider.dart';
// // import 'package:trying_something_2/controllers/provider_class.dart';
// // import 'package:trying_something_2/data/models/ProductFromAPI.dart';
// // import 'package:trying_something_2/services/product_service.dart';
// //
// // import 'body.dart';
// //
// // class SplashHome extends StatefulWidget {
// //   @override
// //   _SplashHomeState createState() => _SplashHomeState();
// // }
// //
// // class _SplashHomeState extends State<SplashHome> {
// //   List<ProductFromApi> productData = [];
// //
// //   //
// //   @override
// //   void initState() {
// //     ProductDataService.getProductData().then((value) {
// //       setState(() {
// //         productData = value!;
// //       });
// //     });
// //     super.initState();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     MagazaShopping magazaShopping = Provider.of<MagazaShopping>(context);
// //     return ListView.builder(
// //       itemCount: productData.length,
// //       itemBuilder: (context, index) {
// //         ProductFromApi productDataList = productData[index];
// //         magazaShopping.magazaSepetEkle(productDataList);
// //
// //         print(magazaShopping.magaza);
// //         return AnimatedSplashScreen(
// //             duration: 6000,
// //             splash: Icons.home,
// //             nextScreen: Home(),
// //             splashTransition: SplashTransition.fadeTransition,
// //             pageTransitionType: PageTransitionType.scale,
// //             backgroundColor: Colors.blue);
// //       },
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:splash_screen_view/SplashScreenView.dart';
// import 'package:trying_something_2/controllers/provider_class.dart';
// import 'package:trying_something_2/data/models/ProductFromAPI.dart';
// import 'package:trying_something_2/services/product_service.dart';
//
// import 'body.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   List<ProductFromApi> productData = [];
//
//   //
//   @override
//   void initState() {
//     ProductDataService.getProductData().then((value) {
//       if (!mounted) return;
//       setState(() {
//         productData = value!;
//         print('Productdata Listesi $productData');
//       });
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print('Product Data Listesi Context İçi $productData');
//     MagazaShopping magazaShopping = Provider.of<MagazaShopping>(context);
//     if (productData.isNotEmpty) {
//       for (int i = 0; i < productData.length; i++) {
//         magazaShopping.magazaSepetEkle(productData[i]);
//       }
//       print('Magazaya Aktarılan ürün Sayısı ${magazaShopping.magaza.length}');
//       print('Mağaza Şuan Dolu');
//     } else {
//       print('Mağaza Şuan Boş');
//     }
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SplashScreenView(
//         navigateRoute: Home(),
//         duration: 5000,
//         imageSize: 130,
//         imageSrc: "assets/splash.png",
//         text: "Shopping Mall",
//         textType: TextType.ColorizeAnimationText,
//         textStyle: TextStyle(
//           fontSize: 40.0,
//         ),
//         colors: [
//           Colors.purple,
//           Colors.blue,
//           Colors.yellow,
//           Colors.red,
//         ],
//         backgroundColor: Colors.white,
//       ),
//     );
//   }
// }
