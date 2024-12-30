import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/user/single_user_provider.dart';
import '../providers/user/update_user_provider.dart';

class UserDetailsScreen extends ConsumerWidget {
  final String userId;

  const UserDetailsScreen(this.userId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(singleUserProvider(userId)).value;
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const Text('FirstName: '),
              Text(detail?.firstName ?? ''),
            ],
          ),
          GestureDetector(
            onTap: () {
              final updated =
                  ref.read(updateUserProvider('${detail?.userId}')).value;
              print('USERFIRSTNAMEIS: $updated');
            },
            child: Row(
              children: [
                const Text('LastName: '),
                Text(detail?.lastName ?? ''),
              ],
            ),
          ),
          Row(
            children: [
              const Text('Date of Birth: '),
              Text(detail?.dob ?? ''),
            ],
          ),
          Row(
            children: [
              const Text('Gender: '),
              Text(detail?.gender ?? ''),
            ],
          ),
        ],
      ),
    );
  }
}
