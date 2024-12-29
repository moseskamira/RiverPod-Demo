import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final updateUserProvider =
    FutureProvider.autoDispose.family<String, String>((ref, userId) {
  String updateMessage = 'Updated Successfully';
  FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .update({'lastName': 'FAZILA3343'})
      .whenComplete(() {})
      .onError((error, stackStrace) {
        updateMessage = error.toString();
      });
  return updateMessage;
});
