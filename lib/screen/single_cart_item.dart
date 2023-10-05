import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/small_text.dart';

class SingleCartItem extends StatefulWidget {
  const SingleCartItem({super.key});

  @override
  State<SingleCartItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  @override
  Widget build(BuildContext context) {
    int quantity = 1;
    return Container(
      margin: EdgeInsets.only(bottom: 12.0),
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
              child: Image.network(
                  "https://asia-exstatic-vivofs.vivo.com/PSee2l50xoirPK7y/1682318654458/26d393361c5543d0771ffb79d1481da8.png"),
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
                        SmallText(text: 'Pixel 6'),
                        SizedBox(
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
                        CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: SmallText(text: "Add to Wishlist"))
                      ],
                    ),
                    SmallText(text: "\$990")
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
