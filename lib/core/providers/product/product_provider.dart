import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_project/core/locator/locator.dart';

import '../../models/product_model.dart';
import '../../network/apis/api_service.dart';

part 'product_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<ProductModel>> products(ref) async {
  return await locator.get<ApiService>().fetchProducts();
}
