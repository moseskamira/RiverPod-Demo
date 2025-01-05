import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/product_model.dart';

part 'cart_provider.g.dart';

@riverpod
class CartNotifier extends _$CartNotifier {
  @override
  Set<ProductModel> build() {
    return {};
  }

  void addProduct(ProductModel productModel) {
    if (!state.contains(productModel)) {
      state = {...state, productModel};
    }
  }

  void removeProduct(ProductModel productModel) {
    if (state.contains(productModel)) {
      state = state.where((element) => element.id != productModel.id).toSet();
    }
  }
}

@riverpod
double cartTotal(ref) {
  double total = 0.0;
  final cartItems = ref.watch(cartNotifierProvider);
  for (ProductModel productModel in cartItems) {
    total += productModel.price!;
  }
  return total;
}
