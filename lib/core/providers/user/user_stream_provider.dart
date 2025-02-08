import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user.dart';

final userStreamProvider = StreamProvider.autoDispose<List<User>>((ref) {
  return FirebaseFirestore.instance
      .collection('users')
      .orderBy('firstName', descending: false)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
            return User.fromJson({...doc.data(), 'userId': doc.id});
          }).toList());
});
