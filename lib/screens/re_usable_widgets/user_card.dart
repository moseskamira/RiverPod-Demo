import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/user.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Column(
      children: [
        Row(
          children: [
            Text('${appLocalizations.firstName}: '),
            Text(user.firstName ?? ''),
          ],
        ),
        Row(
          children: [
            Text('${appLocalizations.lastName}: '),
            Text(user.lastName ?? ''),
          ],
        ),
        Row(
          children: [
            Text('${appLocalizations.dob}: '),
            Text(user.dob ?? ''),
          ],
        ),
        Row(
          children: [
            Text('${appLocalizations.gender}: '),
            Text(user.gender ?? ''),
          ],
        ),
      ],
    );
  }
}
