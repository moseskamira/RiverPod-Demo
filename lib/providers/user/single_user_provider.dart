import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_project/providers/user/user_stream_provider.dart';

import '../../models/user.dart';

final singleUserProvider =
    FutureProvider.autoDispose.family<User?, String>((ref, userId) {
  User? mUser;
  final usersStream = ref.watch(userStreamProvider);
  usersStream.when(
      data: (users) {
        if (users.isNotEmpty) {
          for (User user in users) {
            if (user.userId == userId) {
              mUser = user;
            }
          }
        }
      },
      error: (err, msg) {},
      loading: () => const Center(child: CircularProgressIndicator()));

  return mUser;
});
