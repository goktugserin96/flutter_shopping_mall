// To parse this JSON data, do
//
//     final productFromApi = productFromApiFromJson(jsonString);

import 'dart:convert';

List<ProductFromApi> productFromApiFromJson(String str) =>
    List<ProductFromApi>.from(
        json.decode(str).map((x) => ProductFromApi.fromJson(x)));

String productFromApiToJson(List<ProductFromApi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

enum Category { MEN_S_CLOTHING, JEWELERY, ELECTRONICS, WOMEN_S_CLOTHING }

final categoryValues = EnumValues({
  "electronics": Category.ELECTRONICS,
  "jewelery": Category.JEWELERY,
  "men's clothing": Category.MEN_S_CLOTHING,
  "women's clothing": Category.WOMEN_S_CLOTHING
});

class ProductFromApi {
  ProductFromApi({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
    required this.rating,
    this.initialCount = 0,
  });

  int id;
  String title;
  double price;
  String description;
  int initialCount;
  Category? category;
  String image;
  Rating rating;

  factory ProductFromApi.fromJson(Map<String, dynamic> json) => ProductFromApi(
        id: json["id"],
        title: json["title"],
        price: json["price"].toDouble(),
        description: json["description"],
        image: json["image"],
        rating: Rating.fromJson(json["rating"]),
        category: categoryValues.map![json["category"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "image": image,
        "rating": rating.toJson(),
        "category": categoryValues.reverse![category],
      };
}

class Rating {
  Rating({
    required this.rate,
    required this.count,
  });

  double rate;
  int count;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"].toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
