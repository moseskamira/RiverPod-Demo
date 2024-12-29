import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_project/models/user.dart';

@riverpod
List<User> currentUsers(ref) {
  List<User> users = [];
  FirebaseFirestore.instance.collection('users').snapshots().listen((snapshot) {
    if (snapshot.docs.isNotEmpty) {
      List<User> myList =
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList();
      users.addAll(myList);
      print('CURRENTUSER:${users.first.toJson()}');
    }
  });
  return users;
}
