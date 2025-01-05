import 'package:get_it/get_it.dart';
import 'package:riverpod_project/core/network/repository/user_repository_impl.dart';

import '../network/apis/api_service.dart';
import '../network/repository/user_repository.dart';

final locator = GetIt.instance;

void setUp() {
  locator.registerLazySingleton<ApiService>(() => ApiService());
  locator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
}
