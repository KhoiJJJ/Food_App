import 'package:flutter/material.dart';
import 'package:food_app/screen/products/single_favorite_item.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';
import '../../widgets/custom_app_bar.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const CustomAppBar(
          word1: "E-Commerce",
          word2: "iCart",
        ),
      ),
      body: appProvider.getFavoriteProductList.isEmpty
          ? Container(
              height: 500,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/empty_cart.png"),
                      fit: BoxFit.cover)))
          : ListView.builder(
              itemCount: appProvider.getFavoriteProductList.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                return SingleFavoriteItem(
                  singleProduct: appProvider.getFavoriteProductList[index],
                );
              }),
    );
  }
}
