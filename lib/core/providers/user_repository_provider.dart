import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_project/core/models/user.dart';
import 'package:riverpod_project/core/network/repository/user_repository_impl.dart';

part 'user_repository_provider.g.dart';

@riverpod
Future<List<User>> userRepository(ref) {
  return UserRepositoryImpl().fetchUsers();
}
