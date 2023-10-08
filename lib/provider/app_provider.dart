import 'package:flutter/material.dart';
import 'package:food_app/models/products_model.dart';

class AppProvider with ChangeNotifier{
  //// Care Part
  final List<ProductModel> _cartProductList = [];

  void addCartProduct(ProductModel productModel){
    _cartProductList.add(productModel);
    notifyListeners();
  }

  void removeCartProduct(ProductModel productModel){
    _cartProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getCartProductList => _cartProductList;

  //// Favorite Part
  final List<ProductModel> _favoriteProductList = [];

  void addFavoriteProduct(ProductModel productModel){
    _favoriteProductList.add(productModel);
    notifyListeners();
  }

  void removeFavoriteProduct(ProductModel productModel){
    _favoriteProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getFavoriteProductList => _favoriteProductList;
}