import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navigation_notifier.g.dart';

@riverpod
class AppNavigationNotifier extends _$AppNavigationNotifier {
  @override
  build() {
    return 0;
  }

  void setSelectedIndex(int newIndex) {
    state = newIndex;
  }
}
