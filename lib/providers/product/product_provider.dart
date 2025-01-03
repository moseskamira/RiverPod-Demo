import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_project/locator/locator.dart';
import 'package:riverpod_project/models/product_model.dart';
import 'package:riverpod_project/network/apis/api_service.dart';

part 'product_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<ProductModel>> products(ref) async {
  return await locator.get<ApiService>().fetchProducts();
}
