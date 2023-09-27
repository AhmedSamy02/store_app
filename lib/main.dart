import 'package:flutter/material.dart';
import 'package:store_app/constants.dart';
import 'package:store_app/screens/home_screen.dart';
import 'package:store_app/screens/update_product_screen.dart';
import 'package:store_app/services/get_all_categories.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: kHomeScreen,
      routes: {
        kHomeScreen: (context) => const HomeScreen(),
        kUpdateScreen: (context) => UpdateProductScreen()
      },
    ),
  );
}
