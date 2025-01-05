import 'package:flutter_riverpod/flutter_riverpod.dart';

class _AppNavNotifier extends StateNotifier<int> {
  _AppNavNotifier() : super(0);

  reset(int index) {
    state = index;
  }
}

final appNavProvider =
    StateNotifierProvider.autoDispose<_AppNavNotifier, int>((ref) {
  return _AppNavNotifier();
});
