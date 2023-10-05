import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  String id;
  bool isFavorite;
  String image;
  String name;
  double price;
  String description;
  String status;

  ProductModel(
      {required this.id,
      required this.image,
      required this.name,
      required this.price,
      required this.description,
      required this.status,
      required this.isFavorite});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        isFavorite: false,
        price: double.parse(json["price"].toString()),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
        "isFavorite": isFavorite,
        "price": price,
        "status": status,
      };
}
