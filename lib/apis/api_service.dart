import 'dart:convert';
import 'package:http/http.dart';

class ApiService {
  String endpoint = 'https://dummyjson.com/products';

  Future<List> fetchProducts() async {
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['products'];
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
