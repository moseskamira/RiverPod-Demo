import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPageNotifier extends ChangeNotifier {
  int _tabIndex;

  MainPageNotifier() : _tabIndex = 0;

  int get tabIndex => _tabIndex;

  void setTabIndex(int index) {
    if (_tabIndex != index) {
      _tabIndex = index;
      notifyListeners();
    }
  }
}

final mainPageProvider = ChangeNotifierProvider<MainPageNotifier>((ref) {
  return MainPageNotifier();
});
