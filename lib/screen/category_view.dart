import 'package:flutter/material.dart';
import 'package:food_app/models/categories_model.dart';
import 'package:food_app/screen/product_details.dart';
import 'package:food_app/widgets/top_titles.dart';

import '../constants/routes.dart';
import '../firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import '../models/products_model.dart';
import '../widgets/small_text.dart';

class CategoryView extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryView({super.key, required this.categoryModel});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ProductModel> productModelList = [];

  bool isLoading = false;
  void getCategoriesList() async {
    setState(() {
      isLoading = true;
    });
    productModelList = await FirebaseFirestoreHelper.instance.getCategoryView(widget.categoryModel.id);
    productModelList.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
            )
          :SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TopTitles(title: "", subtitle: widget.categoryModel.name),
                ),
                productModelList.isEmpty
                        ? Center(
                            child: SmallText(
                              text: "Best Products is empty",
                            ),
                          )
                        : Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SmallText(
                        text: 'Best Products',
                        size: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          primary: false,
                          itemCount: productModelList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20,
                                  childAspectRatio: 0.9,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            ProductModel singleProduct = productModelList[index];
                            //Container for product
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Image.network(
                                    singleProduct.image,
                                    height: 60,
                                    width: 60,
                                  ),
                                  SmallText(
                                    text: singleProduct.name,
                                    size: 18,
                                  ),
                                  SmallText(
                                      text: "Price \$${singleProduct.price}"),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  SizedBox(
                                      height: 45,
                                      width: 140,
                                      child: OutlinedButton(
                                          onPressed: () {
                                            Routes.instance.push(widget: ProductDetails(singleProduct: singleProduct), context: context);
                                          },
                                          child: SmallText(
                                            text: "Buy",
                                            color: Colors.red,
                                          )))
                                ],
                              ),
                            );
                          }),
                    )
                  ],
                ),
          ),
            );
  }
}
