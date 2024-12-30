import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_project/models/product_model.dart';

import '../api_service_provider.dart';

part 'product_detail_provider.g.dart';

@Riverpod(keepAlive: true)
class ProductDetailNotifier extends _$ProductDetailNotifier {
  @override
  build() {
    return {};
  }

  Future<ProductModel> getProductDetail(String productId) {
    return ref.read(apiServiceProvider).getProductDetails(productId);
  }
}

//Below is manual way of creating provider
final productDetailProvider =
    Provider.family<Future<ProductModel>, String>((ref, productId) {
  return ref.read(apiServiceProvider).getProductDetails(productId);
});
