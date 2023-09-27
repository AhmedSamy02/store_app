import 'package:store_app/helpers/api.dart';
import 'package:store_app/models/product.dart';

class UpdateProduct {
  UpdateProduct._();
  static final instance = UpdateProduct._();
  static Future<Product> updateProduct({
    required String title,
    required String price,
    required String description,
    required String image,
    required String category,
    required String id,
  }) async {
    var response = await Api.put(
      id: id,
      url: 'https://fakestoreapi.com/products/',
      body: {
        'title': title,
        'price': price,
        'description': description,
        'image': image,
        'category': category,
      },
      token: null,
    );
    if (response.statusCode == 200) {
      return Product.fromMap(response.data);
    } else {
      throw Exception(
          'There\'s an error of status code = ${response.statusCode} \nThe body is ${response.data}');
    }
  }
}
