import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user.dart';

class _AddUserNotifier extends StateNotifier<bool> {
  _AddUserNotifier() : super(false);

  String postUser(User user) {
    String successMsg = 'User Added Successfully';
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
    } catch (_) {
      successMsg = 'An error occurred';
    }
    state = false;
    return successMsg;
  }

  bool get loading => state;
}

final addUserProvider = StateNotifierProvider<_AddUserNotifier, bool>((ref) {
  final notifier = _AddUserNotifier();
  return notifier;
});
