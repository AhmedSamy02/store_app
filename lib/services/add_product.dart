import 'package:store_app/helpers/api.dart';
import 'package:store_app/models/product.dart';

class AddProduct {
  static Future<Product> addProduct({
    required String title,
    required String price,
    required String description,
    required String image,
    required String category,
  }) async {
    var response = await Api.post(
      token: null,
      url: 'https://fakestoreapi.com/products',
      body: {
        'title': title,
        'price': price,
        'description': description,
        'image': image,
        'category': category,
      },
    );
    if (response.statusCode == 200) {
      return Product.fromMap(response.data);
    } else {
      throw Exception(
          'There\'s an error of status code = ${response.statusCode} \nThe body is ${response.data}');
    }
  }
}
