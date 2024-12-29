import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user.dart';
import '../../providers/user/user_stream_provider.dart';

class UsersSection extends ConsumerStatefulWidget {
  const UsersSection({super.key});

  @override
  ConsumerState<UsersSection> createState() => _UsersSectionState();
}

class _UsersSectionState extends ConsumerState<UsersSection> {
  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    final myValue = ref.watch(userStreamProvider).value;
    if (myValue != null) {
      users.clear();
      users.addAll(myValue);
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: users.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
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
                    Text(users[index].firstName ?? ''),
                  ],
                ),
                Row(
                  children: [
                    const Text('LastName: '),
                    Text(users[index].lastName ?? ''),
                  ],
                ),
                Row(
                  children: [
                    const Text('Date of Birth: '),
                    Text(users[index].dob ?? ''),
                  ],
                ),
                Row(
                  children: [
                    const Text('Gender: '),
                    Text(users[index].gender ?? ''),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
