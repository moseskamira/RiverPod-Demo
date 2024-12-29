import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../network/apis/api_service.dart';

part 'api_service_provider.g.dart';

@riverpod
ApiService apiService(ref) {
  return ApiService();
}
