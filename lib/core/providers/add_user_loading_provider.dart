import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddUserLoadingNotifier extends ChangeNotifier {
  bool _isLoading;

  AddUserLoadingNotifier() : _isLoading = false;

  bool get loadingState => _isLoading;

  void setLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      notifyListeners();
    }
  }
}

final userLoadingStateProvider =
    ChangeNotifierProvider<AddUserLoadingNotifier>((ref) {
  return AddUserLoadingNotifier();
});
