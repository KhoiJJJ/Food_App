
import 'package:flutter/material.dart';
import 'package:food_app/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:food_app/models/products_model.dart';
import 'package:food_app/models/user_model.dart';

class AppProvider with ChangeNotifier {
  //// Care Part
  final List<ProductModel> _cartProductList = [];

  UserModel? _userModel;
  UserModel get getUserInformation => _userModel!;

  void addCartProduct(ProductModel productModel) {
    _cartProductList.add(productModel);
    notifyListeners();
  }

  void removeCartProduct(ProductModel productModel) {
    _cartProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getCartProductList => _cartProductList;

  //// Favorite Part
  final List<ProductModel> _favoriteProductList = [];

  void addFavoriteProduct(ProductModel productModel) {
    _favoriteProductList.add(productModel);
    notifyListeners();
  }

  void removeFavoriteProduct(ProductModel productModel) {
    _favoriteProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getFavoriteProductList => _favoriteProductList;

  void getUserInfoFirebase() async {
    _userModel=await FirebaseFirestoreHelper.instance.getUserInformation();
    notifyListeners();
  }

  //// User Part
}
