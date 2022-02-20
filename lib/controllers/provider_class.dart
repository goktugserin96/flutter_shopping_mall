import 'package:flutter/cupertino.dart';

import '../data/models/ProductFromAPI.dart';

class ShoppingProvider extends ChangeNotifier {
  List<ProductFromApi> _magaza = [];

  List<ProductFromApi> get magaza => _magaza;

  void setProduct(List<ProductFromApi> products) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _magaza = products;
      notifyListeners();
    });
  }
}
