import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constants/constants.dart';
import 'package:food_app/constants/routes.dart';
import 'package:food_app/models/products_model.dart';
import 'package:food_app/provider/app_provider.dart';
import 'package:food_app/screen/cart/cart_screen.dart';
import 'package:food_app/screen/cart/check_out_screen.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel singleProduct;
  const ProductDetails({super.key, required this.singleProduct});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              onPressed: () {
                Routes.instance
                    .push(widget: const CartPage(), context: context);
              },
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.singleProduct.image,
                width: 400,
                height: 400,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallText(
                    text: widget.singleProduct.name,
                    size: 18,
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          widget.singleProduct.isFavorite =
                              !widget.singleProduct.isFavorite;
                        });
                        if (widget.singleProduct.isFavorite) {
                          appProvider.addFavoriteProduct(widget.singleProduct);
                        } else {
                          appProvider
                              .removeFavoriteProduct(widget.singleProduct);
                        }
                      },
                      icon: Icon(appProvider.getFavoriteProductList
                              .contains(widget.singleProduct)
                          ? Icons.favorite
                          : Icons.favorite_border)),
                ],
              ),
              SmallText(text: widget.singleProduct.description),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  CupertinoButton(
                    onPressed: () {
                      setState(() {
                        if (quantity != 1) {
                          quantity--;
                        }
                      });
                    },
                    padding: EdgeInsets.zero,
                    child: const CircleAvatar(
                      child: Icon(Icons.remove),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  SmallText(
                    text: quantity.toString(),
                    size: 22,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  CupertinoButton(
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                    padding: EdgeInsets.zero,
                    child: const CircleAvatar(
                      child: Icon(Icons.add),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      ProductModel productModel =
                          widget.singleProduct.copyWith(qty: quantity);
                      appProvider.addCartProduct(productModel);
                      showMessage("Add to cart");
                    },
                    child: SmallText(
                      text: "ADD TO CART",
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        ProductModel productModel =
                            widget.singleProduct.copyWith(qty: quantity);
                        Routes.instance.push(
                            widget: CheckOutPage(
                              singleProduct: productModel,
                            ),
                            context: context);
                      },
                      child: SmallText(text: "BUY"),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
