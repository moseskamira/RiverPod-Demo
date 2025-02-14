import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_project/core/providers/main_page_provider.dart';
import 'package:riverpod_project/ui/screens/dashboard_container.dart';
import 'package:riverpod_project/ui/screens/user_container.dart';

import 'cart_container.dart';
import 'search_container.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  Widget _getBodyContent(int index) {
    switch (index) {
      case 0:
        return const DashboardContainer();
      case 1:
        return const SearchContainer();
      case 2:
        return const SearchContainer();
      case 3:
        return const CartContainer();
      default:
        return const UserContainer();
    }
  }

  NavigationBar _buildBottomNavigationBar(int index) {
    final localizedStrings = AppLocalizations.of(context)!;
    final List<NavigationDestination> destinations = [
      NavigationDestination(
        selectedIcon: const Icon(CommunityMaterialIcons.home),
        icon: const Icon(Icons.home_outlined),
        label: localizedStrings.home,
      ),
      NavigationDestination(
        selectedIcon: const Icon(CommunityMaterialIcons.search_web),
        icon: const Icon(Icons.search),
        label: localizedStrings.search,
      ),
      NavigationDestination(
        selectedIcon: const Icon(Icons.add),
        icon: const Icon(Icons.add),
        label: localizedStrings.add,
      ),
      NavigationDestination(
        selectedIcon: const Icon(CommunityMaterialIcons.cart),
        icon: const Icon(Icons.add_shopping_cart),
        label: localizedStrings.cart,
      ),
      NavigationDestination(
        selectedIcon: const Icon(Icons.person),
        icon: const Icon(Icons.person_2_outlined),
        label: localizedStrings.user,
      ),
    ];

    return NavigationBar(
      destinations: destinations,
      selectedIndex: index,
      indicatorColor: Colors.deepPurple.shade200,
      onDestinationSelected: (value) {
        ref.read(mainPageProvider.notifier).setTabIndex(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabIndex = ref.watch(mainPageProvider).tabIndex;
    final localizedStrings = AppLocalizations.of(context)!;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          localizedStrings.riverPodDemo,
        ),
        centerTitle: true,
      ),
      body: _getBodyContent(tabIndex),
      bottomNavigationBar: _buildBottomNavigationBar(tabIndex),
    );
  }
}
