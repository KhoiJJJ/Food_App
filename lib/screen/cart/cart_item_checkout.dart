import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/firebase/firebase_firestore.dart';

import 'package:food_app/screen/bottom_bar.dart';
import 'package:food_app/widgets/primary_button.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:provider/provider.dart';
import '../../provider/app_provider.dart';
import '../../widgets/custom_app_bar.dart';

class CartItemCheckoutPage extends StatefulWidget {
  const CartItemCheckoutPage({super.key});

  @override
  State<CartItemCheckoutPage> createState() => _CartItemCheckoutPageState();
}

class _CartItemCheckoutPageState extends State<CartItemCheckoutPage> {
  int groupValue = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ), // You can use a different back arrow icon
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const CustomAppBar(
          word1: "E-Commerce",
          word2: "iCart",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 2.0)),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  const Icon(Icons.money),
                  SmallText(text: "Cash on Delivery"),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 2.0)),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  const Icon(Icons.money),
                  SmallText(text: "Pay online"),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            PrimaryButton(
              title: "Continues",
              onPressed: () async {
                bool value = await FirebaseFirestoreHelper.instance
                    .upLoadOrderedProductFirebase(
                        appProvider.getBuyProductList,
                        context,
                        groupValue == 1 ? "Cash on Delivery" : "Pay online");
                appProvider.clearBuyProduct();
                if (value) {
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.of(context, rootNavigator: true)
                        .pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const BottomBar();
                        },
                      ),
                      (_) => false,
                    );
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
