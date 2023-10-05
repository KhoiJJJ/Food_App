import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/products_model.dart';
import 'package:food_app/widgets/small_text.dart';

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
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: Padding(
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
                    },
                    icon: Icon(widget.singleProduct.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border)),
              ],
            ),
            SmallText(text: widget.singleProduct.description),
            const SizedBox(
              height: 12,
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
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                    onPressed: () {},
                    child: SmallText(
                      text: "ADD TO CART",
                    ),),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 150,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: (){},
                    child: SmallText(text: "BUY"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
