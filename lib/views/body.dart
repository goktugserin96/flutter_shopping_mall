import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_mall/views/basket_list_view.dart';

// import 'add_product_view.dart';
import '../controllers/provider_class.dart';
import '../data/models/ProductFromAPI.dart';
import '../services/product_service.dart';
import 'shopping_list_view.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<IconData> iconList = [Icons.shopping_cart, Icons.shopping_bag];
  int _bottomNavIndex = 0;

  late Future<List<ProductFromApi>?> productFromApi;

  void initState() {
    productFromApi = ProductDataService.getProductData();

    super.initState();
  }

  Widget _currentScreen = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //    appBar: AppBar(title: Text("counter")),
      body: FutureBuilder<List<ProductFromApi>?>(
          future: productFromApi,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data!;

              ShoppingProvider magazaShopping =
                  Provider.of<ShoppingProvider>(context);
              magazaShopping.setProduct(data);
              return NavigationScreen(_bottomNavIndex, _currentScreen);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      bottomNavigationBar: AnimatedBottomNavigationBar(
          backgroundColor: Colors.blueGrey[900],
          activeColor: Colors.orange,
          inactiveColor: Colors.white,
          icons: iconList,
          activeIndex: _bottomNavIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.verySmoothEdge,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          iconSize: 30,
          onTap: (index) {
            setState(() {
              _bottomNavIndex = index;
              _currentScreen = (index == 0) ? Store() : MyShoppingList();
            });
          }),
    );

    //other params
  }
}

class NavigationScreen extends StatefulWidget {
  final Widget
      iconData; // aslında currentScreen üşendiğim için değiştirmedim adını
  final int _bottomNavIndex;
  //bir yerden bilgi geliyor bunu okumak için constructor kullanılır.
  NavigationScreen(this._bottomNavIndex, this.iconData) : super();

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void didUpdateWidget(NavigationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.iconData != widget.iconData) {
      _startAnimation();
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
    _controller.forward();
    super.initState();
  }

  _startAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Center(
        child: CircularRevealAnimation(
          animation: animation,
          centerOffset: Offset(80, 80),
          maxRadius: MediaQuery.of(context).size.longestSide * 1.1,
          child: widget.iconData,
        ),
      ),
    );
  }
}
