import 'package:http/http.dart' as http;

import '../data/models/ProductFromAPI.dart';

class ProductDataService {
  static ProductDataService _singleton = ProductDataService._internal();
  ProductDataService._internal();
  factory ProductDataService() {
    return _singleton;
  }

  static Future<List<ProductFromApi>?> getProductData() async {
    try {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));
      // if (response.body.isNotEmpty) {
      if (response.statusCode == 200) {
        final responseJson = productFromApiFromJson(response.body);

        return responseJson;
      } else {
        return Future.error(
            "This is the error", StackTrace.fromString("This is its trace"));
      }
    } catch (error) {
      Exception(error);
    }
  }
}
