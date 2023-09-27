import 'package:dio/dio.dart';
import 'package:store_app/helpers/api.dart';
import 'package:store_app/models/product.dart';

class GetProductsByCategory {
  GetProductsByCategory._();
  static final instance = GetProductsByCategory._();
  static late Future<List<Product>> future;
  void execute(String category) {
    future = getProducts(category);
  }

  Future<List<Product>> getProducts(String category) async {
    List<Product> products = [];
    final url =
        Uri.encodeFull('https://fakestoreapi.com/products/category/$category');
    final response = await Api.get(url);
    for (var i = 0; i < response.data!.length; i++) {
      products.add(Product.fromMap(response.data![i]));
    }
    return products;
  }
}
