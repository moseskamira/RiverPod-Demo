import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_project/models/product_model.dart';

import '../api_service_provider.dart';

part 'product_detail_provider.g.dart';

@Riverpod(keepAlive: true)
Future<ProductModel> productDetail(ref, String prodId) async {
  return await ref.read(apiServiceProvider).getProductDetails(prodId);
}
