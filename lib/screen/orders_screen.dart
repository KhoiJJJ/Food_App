import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/firebase/firebase_firestore.dart';
import 'package:food_app/models/orders_model.dart';
import 'package:food_app/widgets/small_text.dart';

import '../widgets/custom_app_bar.dart';

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
          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(
              child: SmallText(text: "No Order Founded"),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              OrderModel orderModel = snapshot.data![index];
              return ExpansionTile(
                title: Text(
                  orderModel.payment,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      orderModel.status,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
