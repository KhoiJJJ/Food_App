// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constants/constants.dart';
import 'package:food_app/firebase/firebase_firestore.dart';
import 'package:food_app/firebase/firebase_storage.dart';
import 'package:food_app/models/products_model.dart';
import 'package:food_app/models/user_model.dart';

class AppProvider with ChangeNotifier {
  //// Care Part
  final List<ProductModel> _cartProductList = [];
  final List<ProductModel> _buyProductList = [];

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

  //// User Part
  void getUserInfoFirebase() async {
    _userModel = await FirebaseFirestoreHelper.instance.getUserInformation();
    notifyListeners();
  }

  void updateUserInfoFirebase(
      UserModel userModel, File? file, BuildContext context) async {
    showLoaderDialog(context);
    if (file == null) {
      _userModel = userModel;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());
      showMessage("Successfully updated profile");
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();
    } else {
      String imageUrl =
          await FirebaseStorageHelper.instance.upLoadUserImage(file);
      _userModel = userModel.copyWith(image: imageUrl);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());
      showMessage("Successfully updated profile");
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();
    }
    notifyListeners();
  }
  ////// TOTAL PRICE

  double totalPrice() {
    double totalPrice = 0.0;
    for (var e in _cartProductList) {
      totalPrice += e.price * e.qty!;
    }
    return totalPrice;
  }

  void updateQty(ProductModel productModel, int qty) {
    int index = _cartProductList.indexOf(productModel);
    _cartProductList[index].qty = qty;
    notifyListeners();
  }

  //// BUY PRODUCT
  void addBuyProduct(ProductModel model) {
    _buyProductList.add(model);
    notifyListeners();
  }

  void addBuyProductCartList() {
    _buyProductList.addAll(_cartProductList);
    notifyListeners();
  }

  void clearBuyProduct() {
    _buyProductList.clear();
    notifyListeners();
  }

  List<ProductModel> get getBuyProductList => _buyProductList;
}
