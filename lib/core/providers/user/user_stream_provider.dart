import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user.dart';

final userStreamProvider = StreamProvider.autoDispose<List<User>>((ref) {
  final controller = StreamController<List<User>>();
  controller.onListen = () {
    controller.sink.add([]);
  };

  final sub = FirebaseFirestore.instance
      .collection('users')
      .orderBy('firstName', descending: false)
      .snapshots()
      .listen((snapshot) {
    if (snapshot.docs.isNotEmpty) {
      List<User> myList = snapshot.docs.map((doc) {
        return User.fromJson({...doc.data(), 'userId': doc.id});
      }).toList();
      controller.sink.add(myList);
    }
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
