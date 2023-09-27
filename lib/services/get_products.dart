import 'package:dio/dio.dart';
import 'package:store_app/helpers/api.dart';
import 'package:store_app/models/product.dart';

class GetProducts {
  GetProducts._();
  static final instance = GetProducts._();
  static Future<List<Product>> future = instance.getProducts();

  final url = 'https://fakestoreapi.com/products';

  Future<List<Product>> getProducts() async {
    List<Product> products = [];
    final response = await Api.get(url);
    for (var i = 0; i < response.data!.length; i++) {
      products.add(Product.fromMap(response.data![i]));
    }
    return products;
  }
}
