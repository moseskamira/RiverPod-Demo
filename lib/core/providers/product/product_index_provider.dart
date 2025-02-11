import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductIndexNotifier extends ChangeNotifier {
  int _index;

  ProductIndexNotifier() : _index = 0;

  int get pageIndex => _index;

  void setPageIndex(int index) {
    if (_index != index) {
      _index = index;
      notifyListeners();
    }
  }
}

final productIndexProvider =
    ChangeNotifierProvider<ProductIndexNotifier>((ref) {
  return ProductIndexNotifier();
});
