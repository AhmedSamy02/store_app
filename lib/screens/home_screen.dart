import 'package:cached_network_image/cached_network_image.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:store_app/constants.dart';
import 'package:store_app/models/product.dart';
import 'package:store_app/services/get_all_categories.dart';
import 'package:store_app/services/get_products.dart';
import 'package:store_app/services/get_products_by_category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    future = GetProducts.instance.getProducts();
  }

  int tag = 0;
  List<String> categories = [
    'All',
  ];
  String data = '';
  int _selectedIndex = 0;
  List<MaterialColor> loveColor = List.filled(50, Colors.grey);
  late Future<List<Product>> future;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              //TODO Shopping Cart code
            },
            icon: const Icon(
              Icons.shopping_cart,
              color: Color.fromARGB(190, 0, 0, 0),
            ),
          ),
        ],
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black38),
        centerTitle: true,
        title: const Text(
          'New Trend',
          style: TextStyle(color: Colors.black),
        ),
      ),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        iconSize: 24,
        height: 55,
        items: [
          FlashyTabBarItem(
            icon: const Icon(Icons.home_filled),
            title: const Text('Home'),
            activeColor: Colors.brown,
            inactiveColor: Colors.grey,
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.search),
            title: const Text('Search'),
            activeColor: Colors.brown,
            inactiveColor: Colors.grey,
          ),
          FlashyTabBarItem(
            icon: const Icon(CupertinoIcons.cart_fill),
            title: const Text('Cart'),
            activeColor: Colors.brown,
            inactiveColor: Colors.grey,
          ),
          FlashyTabBarItem(
            icon: const Icon(CupertinoIcons.heart_fill),
            title: const Text('Favourites'),
            activeColor: Colors.brown,
            inactiveColor: Colors.grey,
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.person_2_outlined),
            title: const Text('Profile'),
            activeColor: Colors.brown,
            inactiveColor: Colors.grey,
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: 700,
        child: ModalProgressHUD(
          inAsyncCall: _isLoading,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: FutureBuilder(
                    future: GetAllCategories.future,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        categories.clear();
                        categories.add('All');
                        categories.addAll(snapshot.data!);
                      }
                      return ChipsChoice<int>.single(
                        value: tag,
                        onChanged: (value) async {
                          setState(() {
                            tag = value;
                            _isLoading = true;
                          });
        
                          if (tag == 0) {
                            setState(() {
                              future = GetProducts.instance.getProducts();
                              _isLoading = false;
                            });
                            return;
                          }
                          GetProductsByCategory.instance
                              .execute(categories[value]);
                          setState(() {
                            future = GetProductsByCategory.future;
                            _isLoading = false;
                          });
                        },
                        choiceItems: C2Choice.listFrom<int, String>(
                          source: categories,
                          value: (i, v) => i,
                          label: (i, v) => v,
                        ),
                      );
                    },
                  ),
                ),
              ),
              FutureBuilder<List<Product>>(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SliverGrid.builder(
                      itemCount: snapshot.data!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.98,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 20,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, kUpdateScreen,
                                arguments: snapshot.data![index]);
                          },
                          child: Card(
                            elevation: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data![index].image ??
                                          kImageNotFound,
                                      fit: BoxFit.contain,
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Center(
                                              child: Icon(Icons.error)),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 10, top: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            snapshot.data![index].title!,
                                            maxLines: 2,
                                            style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 15,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w400),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              '\$${snapshot.data![index].price!.toStringAsFixed(2)}',
                                              style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Colors.black87,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (loveColor[index] ==
                                                      Colors.grey) {
                                                    loveColor[index] =
                                                        Colors.red;
                                                  } else {
                                                    loveColor[index] =
                                                        Colors.grey;
                                                  }
                                                });
                                              },
                                              icon: Icon(
                                                CupertinoIcons.heart_fill,
                                                color: Color(
                                                    loveColor[index].value),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
