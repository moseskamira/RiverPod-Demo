import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final updateUserProvider = Provider.family<String, String>((ref, userId) {
  String updateMessage = 'Updated Successfully';
  FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .update({'firstName': 'FAZIL'})
      .whenComplete(() {})
      .onError((error, stackStrace) {
        updateMessage = error.toString();
      });
  return updateMessage;
});
