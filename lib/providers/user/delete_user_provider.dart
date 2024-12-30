import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_user_provider.g.dart';

@Riverpod(keepAlive: true)
String deleteUser(ref, String docId) {
  FirebaseFirestore.instance.collection('users').doc(docId).delete();
  return 'User deleted successfully';
}
