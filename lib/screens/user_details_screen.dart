import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/user/delete_user_provider.dart';
import '../providers/user/single_user_provider.dart';
import '../providers/user/update_user_provider.dart';
import '../utils/reusable_functions.dart';

class UserDetailsScreen extends ConsumerWidget {
  final String userId;

  const UserDetailsScreen(this.userId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(singleUserProvider(userId));
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('FirstName: '),
                    Text(detail?.firstName ?? ''),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    ref.read(updateUserProvider('${detail?.userId}'));
                  },
                  child: Text('Updated Name'),
                )
              ],
            ),
            Row(
              children: [
                const Text('LastName: '),
                Text(detail?.lastName ?? ''),
              ],
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
            GestureDetector(
              onTap: () {
                final result =
                    ref.read(deleteUserProvider('${detail?.userId}'));
                if (result.isNotEmpty) {
                  Navigator.of(context).pop();
                  final snackBar = ReUsableFunctions.awesomeSnackBar(
                      'User Details', result, ContentType.success, context);
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
                }
              },
              child: Text(
                'Delete User',
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
