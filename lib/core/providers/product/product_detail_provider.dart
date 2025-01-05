import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_project/core/locator/locator.dart';

import '../../models/product_model.dart';
import '../../network/apis/api_service.dart';

part 'product_detail_provider.g.dart';

@Riverpod(keepAlive: true)
Future<ProductModel> productDetail(ref, String prodId) async {
  return await locator.get<ApiService>().getProductDetails(prodId);
}
