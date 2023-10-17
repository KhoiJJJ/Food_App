// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:food_app/firebase/firebase_firestore.dart';
import 'package:food_app/models/categories_model.dart';
import 'package:food_app/models/products_model.dart';
import 'package:food_app/provider/app_provider.dart';
import 'package:food_app/screen/category_view.dart';
import 'package:food_app/screen/product_details.dart';
import 'package:food_app/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

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
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
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

  TextEditingController search = TextEditingController();
  List<ProductModel> searchList = [];
  void searchProducts(String value) {
    searchList = productModelList
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();

    setState(() {});
  }

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
      body: isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
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
                          TextFormField(
                            controller: search,
                            onChanged: (String value) {
                              searchProducts(value);
                            },
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
                                        onTap: () {
                                          Routes.instance.push(
                                              widget: CategoryView(
                                                  categoryModel: e),
                                              context: context);
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
                  const SizedBox(
                    height: 15,
                  ),
                  !isSearched()
                      ? Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SmallText(
                            text: 'Best Products',
                            size: 18,
                          ),
                        )
                      : SizedBox.fromSize(),
                  search.text.isNotEmpty && searchList.isEmpty
                      ? Center(
                          child: SmallText(text: "No Product Founded"),
                        )
                      : searchList.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GridView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: searchList.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 20,
                                          crossAxisSpacing: 20,
                                          childAspectRatio: 0.9,
                                          crossAxisCount: 2),
                                  itemBuilder: (context, index) {
                                    ProductModel singleProduct =
                                        searchList[index];
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
                                              text:
                                                  "Price \$${singleProduct.price}"),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          SizedBox(
                                              height: 45,
                                              width: 140,
                                              child: OutlinedButton(
                                                  onPressed: () {
                                                    Routes.instance.push(
                                                        widget: ProductDetails(
                                                            singleProduct:
                                                                singleProduct),
                                                        context: context);
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
                          : productModelList.isEmpty
                              ? Center(
                                  child: SmallText(
                                    text: "Best Products is empty",
                                  ),
                                )
                              : Padding(
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
                                        ProductModel singleProduct =
                                            productModelList[index];
                                        //Container for product
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(15),
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
                                                  text:
                                                      "Price \$${singleProduct.price}"),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              SizedBox(
                                                  height: 45,
                                                  width: 140,
                                                  child: OutlinedButton(
                                                      onPressed: () {
                                                        Routes.instance.push(
                                                            widget: ProductDetails(
                                                                singleProduct:
                                                                    singleProduct),
                                                            context: context);
                                                      },
                                                      child: SmallText(
                                                        text: "Buy",
                                                        color: Colors.red,
                                                      )))
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                ],
              ),
            ),
    );
  }

  bool isSearched() {
    if (search.text.isNotEmpty && searchList.isEmpty) {
      return true;
    } else if (search.text.isEmpty && searchList.isNotEmpty) {
      return false;
    } else if (searchList.isNotEmpty) {
      return false;
    } else {
      return false;
    }
  }
}
