import 'package:food_app/models/products_model.dart';

class OrderModel {
  String payment;
  String status;
  List<ProductModel> products;
  double totalPrice;
  String orderId;

  OrderModel({
    required this.payment,
    required this.status,
    required this.totalPrice,
    required this.products,
    required this.orderId,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productMap = json["products"];
    return OrderModel(
        orderId: json["orderId"],
        products: productMap.map((e) => ProductModel.fromJson(e)).toList(),
        payment: json["payment"],
        totalPrice: json["totalPrice"],
        status: json["status"]);
  }
}
