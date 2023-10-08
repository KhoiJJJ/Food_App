import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/products_model.dart';
import 'package:provider/provider.dart';
import '../provider/app_provider.dart';
import '../widgets/show_alert.dart';
import '../widgets/small_text.dart';

class SingleCartItem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleCartItem({super.key, required this.singleProduct});

  @override
  State<SingleCartItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  int quantity = 1;
  @override
  void initState() {
    quantity = widget.singleProduct.qty ?? 1;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
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
                        const SizedBox(
                          height: 10,
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
                                maxRadius: 13,
                                child: Icon(Icons.remove),
                              ),
                            ),
                            SmallText(
                              text: quantity.toString(),
                              size: 22,
                            ),
                            CupertinoButton(
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              padding: EdgeInsets.zero,
                              child: const CircleAvatar(
                                maxRadius: 13,
                                child: Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  if (!appProvider.getFavoriteProductList
                                      .contains(widget.singleProduct)) {
                                    appProvider.addFavoriteProduct(
                                        widget.singleProduct);
                                  } else {
                                    appProvider.removeFavoriteProduct(
                                        widget.singleProduct);
                                  }
                                },
                                child: SmallText(
                                    text: appProvider.getFavoriteProductList
                                            .contains(widget.singleProduct)
                                        ? "Remove from Wishlist"
                                        : "Add to Wishlist")),
                            CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  appProvider
                                      .removeCartProduct(widget.singleProduct);
                                  showAlert(context, "Removed");
                                },
                                child: const CircleAvatar(
                                    maxRadius: 13,
                                    child: Icon(
                                      Icons.delete,
                                      size: 20,
                                    ))),
                          ],
                        )
                      ],
                    ),
                    SmallText(
                        text: "\$${widget.singleProduct.price.toString()}"),
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
