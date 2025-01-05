import 'dart:async';

import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_project/core/locator/locator.dart';

import '../../models/product_model.dart';
import '../../network/apis/api_service.dart';

part 'product_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<ProductModel>> products(ProductsRef ref) async {
  final logger = Logger();
  try {
    return await locator.get<ApiService>().fetchProducts();
  } catch (e, _) {
    logger.e("Error fetching products");
    return [];
  }
}
