import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/firebase/firebase_firestore.dart';
import 'package:food_app/models/orders_model.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/small_text.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
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
      body: FutureBuilder(
        future: FirebaseFirestoreHelper.instance.getUserOrder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                OrderModel orderModel = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    tilePadding: EdgeInsets.zero,
                    collapsedShape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.red, width: 2.3)),
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.red, width: 2.3)),
                    title: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 150,
                            child: Image.network(orderModel.products[0].image),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 140,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SmallText(text: orderModel.products[0].name),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  orderModel.products.length > 1
                                      ? SizedBox.fromSize()
                                      : SmallText(
                                          text:
                                              "Quantity: ${orderModel.products[0].qty.toString()}"),
                                  SmallText(
                                      text:
                                          "Total Price: \$${orderModel.totalPrice.toString()}"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SmallText(
                                      text:
                                          "Order status: ${orderModel.status}"),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    children: orderModel.products.length > 1
                        ? [
                            SmallText(text: "Details"),
                            const Divider(
                              color: Colors.black,
                            ),
                            ...orderModel.products.map((singleProduct) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: 80,
                                          child: Image.network(
                                              singleProduct.image),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SmallText(
                                                    text: singleProduct.name),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                SmallText(
                                                    text:
                                                        "Quantity: ${singleProduct.qty.toString()}"),
                                                SmallText(
                                                    text:
                                                        "Price: \$${singleProduct.price.toString()}"),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.black,
                                  )
                                ],
                              );
                            }).toList()
                          ]
                        : [],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
