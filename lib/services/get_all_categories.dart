import 'package:store_app/helpers/api.dart';

class GetAllCategories {
  GetAllCategories._();
  static final instance = GetAllCategories._();
  static Future<List<String>> future = instance.getCategories();
  final url = 'https://fakestoreapi.com/products/categories';
  Future<List<String>> getCategories() async {
    List<String> categories = [];

    final response = await Api.get(url);

    for (var i = 0; i < response.data!.length; i++) {
      categories.add(response.data![i]);
    }
    return categories;
  }
}
