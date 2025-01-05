import 'dart:convert';

import 'package:http/http.dart';

import '../../models/product_model.dart';
import 'apis.dart';

class ApiService {
  String baseUrl = 'https://dummyjson.com/';

  Future<List<ProductModel>> fetchProducts() async {
    Response response = await get(Uri.parse('$baseUrl${Apis.products}'));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['products'];
      return result
          .map((jsonValues) => ProductModel.fromJson(jsonValues))
          .toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<ProductModel> getProductDetails(String id) async {
    Response response = await get(Uri.parse('$baseUrl${Apis.products}/$id'));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return ProductModel.fromJson(result);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
