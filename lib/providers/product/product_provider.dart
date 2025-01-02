import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_project/models/product_model.dart';
import 'package:riverpod_project/providers/api_service_provider.dart';

part 'product_provider.g.dart';

@riverpod
Future<List<ProductModel>> products(ref) async {
  return await ref.read(apiServiceProvider).fetchProducts();
}
