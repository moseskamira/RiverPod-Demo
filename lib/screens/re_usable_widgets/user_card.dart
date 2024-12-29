import 'package:flutter/material.dart';

import '../../models/user.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
