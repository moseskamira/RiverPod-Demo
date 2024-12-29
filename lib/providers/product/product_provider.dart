import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_project/providers/api_service_provider.dart';

part 'product_provider.g.dart';

@riverpod
Future<List> products(ref) {
  return ref.read(apiServiceProvider).fetchProducts();
}
