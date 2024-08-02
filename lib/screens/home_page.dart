import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_project/providers/navigation_notifier.dart';
import 'package:riverpod_project/screens/dashboard_container.dart';
import 'package:riverpod_project/screens/orders_container.dart';
import '../providers/product_provider.dart';
import 'account_container.dart';

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
    final index = ref.watch(appNavigationNotifierProvider) as int;
    final productsFuture = ref.watch(productsProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Products'),
        centerTitle: true,
      ),
      body: [
        const DashboardContainer(),
        const OrdersContainer(),
        const AccountContainer()
      ][index],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.sd_card_alert_sharp),
            icon: Icon(Icons.sd_card_alert_sharp),
            label: 'Orders',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_2_outlined),
            label: 'Account',
          ),
        ],
        selectedIndex: index,
        indicatorColor: Colors.deepPurple.shade200,
        onDestinationSelected: (value) {
          ref
              .read(appNavigationNotifierProvider.notifier)
              .setSelectedIndex(value);
        },
      ),
    );
  }
}
