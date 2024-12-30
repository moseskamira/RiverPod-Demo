import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_project/models/user.dart';

class _UsersNotifier extends StateNotifier<List<User>> {
  _UsersNotifier() : super([]);
  bool isLoading = true;

  Future<void> setAll(List<User> users, bool loadingValue) async {
    state = users;
    isLoading = loadingValue;
  }

  List<User> get getUsers => state;
}

final userProvider = StateNotifierProvider<_UsersNotifier, List<User>>(
  (ref) {
    final notifier = _UsersNotifier();
    final subscription = FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<User> myList =
            snapshot.docs.map((doc) => User.fromJson(doc.data())).toList();
        notifier.setAll(myList, false);
      }
    });

    ref.onDispose(() {
      subscription.cancel();
    });
    return notifier;
  },
);
