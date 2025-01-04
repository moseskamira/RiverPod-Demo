import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:riverpod_project/models/user.dart';
import 'package:riverpod_project/network/repository/user_repository.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl();

  @override
  Future<List<User>> fetchUsers() async {
    List<User> users = [];
    FirebaseFirestore.instance
        .collection('users')
        .orderBy('firstName', descending: false)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<User> myList = snapshot.docs.map((doc) {
          return User.fromJson({...doc.data(), 'userId': doc.id});
        }).toList();
        users.addAll(myList);
      }
    });
    return users;
  }
}
