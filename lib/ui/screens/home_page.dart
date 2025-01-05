import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_project/core/providers/app_nav_provider.dart';
import 'package:riverpod_project/ui/screens/products_container.dart';
import 'package:riverpod_project/ui/screens/user_container.dart';

import 'orders_container.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final index = ref.watch(appNavProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.products),
        centerTitle: true,
      ),
      body: [
        const ProductsContainer(),
        const OrdersContainer(),
        const UserContainer()
      ][index],
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            selectedIcon: const Icon(Icons.home),
            icon: const Icon(Icons.home_outlined),
            label: AppLocalizations.of(context)!.product,
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.sd_card_alert_sharp),
            icon: const Icon(Icons.sd_card_alert_sharp),
            label: AppLocalizations.of(context)!.order,
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.person),
            icon: const Icon(Icons.person_2_outlined),
            label: AppLocalizations.of(context)!.user,
          ),
        ],
        selectedIndex: index,
        indicatorColor: Colors.deepPurple.shade200,
        onDestinationSelected: (value) {
          ref.read(appNavProvider.notifier).reset(value);
        },
      ),
    );
  }
}
