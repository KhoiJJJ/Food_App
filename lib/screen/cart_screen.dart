
import 'package:flutter/material.dart';
import 'package:food_app/screen/single_cart_item.dart';

import '../widgets/custom_app_bar.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const CustomAppBar(
          word1: "E-Commerce",
          word2: "iCart",
        ),
      ),
      body: ListView.builder(
          itemCount: 4,
          padding: const EdgeInsets.all(12),
          itemBuilder: (context, index) {
            return const SingleCartItem();
          }),
    );
  }
}


