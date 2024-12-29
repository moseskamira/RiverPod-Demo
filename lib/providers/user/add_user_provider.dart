import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user.dart';

class _AddUserNotifier extends StateNotifier<bool> {
  _AddUserNotifier() : super(false);

  postUser(User user) {
    state = true;
    try {
      final fireStore = FirebaseFirestore.instance;
      final docRef = fireStore.collection('users').doc();
      fireStore.runTransaction((transaction) async {
        transaction.set(docRef, {
          'firstName': user.firstName,
          'lastName': user.lastName,
          'gender': user.gender,
          'dob': user.dob,
        });
      });
    } catch (_) {}
    state = false;
  }

  bool get loading => state;
}

final newAddUserProvider = StateNotifierProvider<_AddUserNotifier, bool>((ref) {
  final notifier = _AddUserNotifier();
  return notifier;
});
