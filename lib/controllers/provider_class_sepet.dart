import 'package:flutter/cupertino.dart';

import '../data/models/ProductFromAPI.dart';

class BasketProvider extends ChangeNotifier {
  List<ProductFromApi> _sepet = [];

  List<ProductFromApi> get sepet => _sepet;

  double _totalPrice = 0;

  double get totalPrice => _totalPrice;

  //
  // int _count = 1;
  //
  // int get count => _count;

  void addList(ProductFromApi item) {
    _totalPrice += item.price;

    _sepet.add(item);
    item.initialCount++;
    notifyListeners();
  }

  void removeList(ProductFromApi item) {
    _totalPrice -= item.price;

    _sepet.remove(item);
    item.initialCount--;
    notifyListeners();
  }

  void clear1(List<ProductFromApi> item) {
    for (int i = 0; i < item.length; i++) {
      item[i].initialCount = 0;
    }

    _totalPrice = 0;

    _sepet = [];

    notifyListeners();
  }
}
