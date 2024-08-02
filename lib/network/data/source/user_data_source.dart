import '../../../models/user.dart';

abstract class UserDataSource {
  Future<List<User>> returnUsers();
}
