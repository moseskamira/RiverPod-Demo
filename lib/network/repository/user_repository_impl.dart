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
    final fireStore = FirebaseFirestore.instance;
    final userSnapShots = fireStore.collection('users').snapshots();
    userSnapShots.asyncMap((snapshot) {
      List<DocumentSnapshot> documentSnapshots = snapshot.docs;
      if (documentSnapshots.isNotEmpty) {
        final usersList = documentSnapshots
            .map((element) => User.fromJson(element as Map<String, dynamic>))
            .toList();
        users.addAll(usersList);
        print('MYDOCS: ${usersList}');
      }
    });
    return users;
  }
}
