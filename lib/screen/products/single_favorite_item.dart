import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constants/constants.dart';
import 'package:food_app/models/products_model.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';

import '../../widgets/small_text.dart';

class SingleFavoriteItem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleFavoriteItem({super.key, required this.singleProduct});

  @override
  State<SingleFavoriteItem> createState() => _SingleFavoriteItemState();
}

class _SingleFavoriteItemState extends State<SingleFavoriteItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red, width: 3),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 140,
              color: Colors.red.withOpacity(0.5),
              child: Image.network(widget.singleProduct.image),
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 140,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmallText(text: widget.singleProduct.name),
                        CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              AppProvider appProvider =
                                  Provider.of<AppProvider>(context,
                                      listen: false);
                              appProvider
                                  .removeFavoriteProduct(widget.singleProduct);
                              showMessage("Removed");
                            },
                            child: SmallText(text: "Removed from Wishlist"))
                      ],
                    ),
                    SmallText(
                        text: "\$${widget.singleProduct.price.toString()}")
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
