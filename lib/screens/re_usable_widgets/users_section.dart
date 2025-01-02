import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_project/screens/re_usable_widgets/user_card.dart';

import '../../app_routes/route_path.dart';
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
      child: usersStream.isLoading
          ? const Center(child: CircularProgressIndicator())
          : usersStream.when(
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
                          child: GestureDetector(
                            onTap: () {
                              if (user.userId != null && context.mounted) {
                                context.push(RoutePath.userDetailsView,
                                    extra: {'userId': user.userId!});
                              }
                            },
                            child: UserCard(user: user),
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
