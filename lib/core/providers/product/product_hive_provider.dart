import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_project/core/models/local_product_model.dart';

enum CartStatus { loading, success, error, empty }

class ProductHiveNotifier extends ChangeNotifier {
  ProductHiveNotifier() {
    loadCartItems();
  }

  final Box<LocalProductModel> _cartBox =
      Hive.box<LocalProductModel>('cart_box');
  CartStatus _status = CartStatus.loading;
  List<LocalProductModel> _cartItems = [];

  List<LocalProductModel> get cartItems => _cartItems;

  CartStatus get status => _status;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> loadCartItems() async {
    try {
      _status = CartStatus.loading;
      notifyListeners();

      _cartItems = _cartBox.values.toList();
      _status = _cartItems.isEmpty ? CartStatus.empty : CartStatus.success;
    } catch (e) {
      _status = CartStatus.error;
      _errorMessage = 'Failed to load cart items';
    } finally {
      notifyListeners();
    }
  }

  Future<void> addToCart(LocalProductModel product) async {
    try {
      await _cartBox.add(product);
      loadCartItems();
    } catch (e) {
      _status = CartStatus.error;
      _errorMessage = 'Failed to add item to cart';
      notifyListeners();
    }
  }

  Future<void> deleteCartItem(int index) async {
    try {
      if (index >= 0 && index < _cartBox.length) {
        await _cartBox.deleteAt(index);
        loadCartItems();
      }
    } catch (e) {
      _status = CartStatus.error;
      _errorMessage = 'Failed to delete cart item';
      notifyListeners();
    }
  }

  Future<void> clearCart() async {
    try {
      await _cartBox.clear();
      loadCartItems();
    } catch (e) {
      _status = CartStatus.error;
      _errorMessage = 'Failed to clear cart';
      notifyListeners();
    }
  }
}

final productHiveProvider = ChangeNotifierProvider<ProductHiveNotifier>((ref) {
  return ProductHiveNotifier();
});
