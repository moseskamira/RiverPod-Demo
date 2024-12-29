import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/user/user_stream_provider.dart';

class UsersSection extends ConsumerStatefulWidget {
  const UsersSection({super.key});

  @override
  ConsumerState<UsersSection> createState() => _UsersSectionState();
}

class _UsersSectionState extends ConsumerState<UsersSection> {
  @override
  Widget build(BuildContext context) {
    final usersStream = ref.watch(userStreamProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: usersStream.when(
          data: (users) {
            return Column(
              children: users
                  .map(
                    (user) => Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text('FirstName: '),
                              Text(user.firstName ?? ''),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('LastName: '),
                              Text(user.lastName ?? ''),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('Date of Birth: '),
                              Text(user.dob ?? ''),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('Gender: '),
                              Text(user.gender ?? ''),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            );
          },
          error: (err, ms) => Text(err.toString()),
          loading: () => const Center(child: CircularProgressIndicator())),
    );
  }
}
