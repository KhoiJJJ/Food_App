import 'package:flutter/material.dart';
import 'package:food_app/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:food_app/models/categories_model.dart';
import 'package:food_app/models/products_model.dart';
import 'package:food_app/screen/category_view.dart';
import 'package:food_app/screen/product_details.dart';
import 'package:food_app/widgets/top_titles.dart';

import '../constants/routes.dart';
import '../widgets/small_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];

  bool isLoading = false;
  @override
  void initState() {
    getCategoriesList();
    super.initState();
  }

  void getCategoriesList() async {
    setState(() {
      isLoading = true;
    });
    categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
    productModelList = await FirebaseFirestoreHelper.instance.getBestProducts();
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
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TopTitles(title: "iCart", subtitle: ''),
                          TextFormField(
                            decoration: const InputDecoration(
                                hintText: 'Search',
                                suffixIcon: Icon(Icons.search)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SmallText(
                            text: 'Categories',
                            size: 18,
                          ),
                        ],
                      )),
                  categoriesList.isEmpty
                      ? Center(
                          child: SmallText(
                            text: "Categories is empty",
                          ),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: categoriesList
                                .map((e) => Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: GestureDetector(
                                        onTap: (){
                                          Routes.instance.push(widget: CategoryView(categoryModel: e), context: context);
                                        },
                                        child: Card(
                                          color: Colors.white,
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: Image.network(e.image),
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                  SizedBox(
                    height: 15,
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
