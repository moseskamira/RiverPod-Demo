import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:riverpod_project/core/network/data/source/user_data_source.dart';

import '../../../models/user.dart';

@LazySingleton(as: UserDataSource)
class UserDataSourceImpl implements UserDataSource {
  @override
  Future<List<User>> returnUsers() async {
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

    // TODO: implement returnUsers
    throw UnimplementedError();
  }
}
