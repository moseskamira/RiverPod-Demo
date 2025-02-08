import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_project/ui/app_routes/route_path.dart';
import 'package:riverpod_project/ui/screens/home_page.dart';
import 'package:riverpod_project/ui/screens/user_details_screen.dart';

import '../screens/product_detail_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

Map<String, dynamic>? _getStateExtras(GoRouterState state) {
  return state.extra as Map<String, dynamic>?;
}

Widget _productDetailsBuilder(_, GoRouterState state) {
  final stateExtras = _getStateExtras(state);
  final prodId = stateExtras?['prodId'];
  return ProductDetailPage(prodId);
}

Widget _userDetailsBuilder(_, GoRouterState state) {
  final stateExtras = _getStateExtras(state);
  var userId = stateExtras?['userId'];
  return UserDetailsScreen(userId);
}

final appRouter = GoRouter(navigatorKey: _rootNavigatorKey, routes: [
  GoRoute(
    name: "homeView",
    path: RoutePath.homeView,
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    name: "productDetailsView",
    path: RoutePath.productDetailsView,
    builder: _productDetailsBuilder,
  ),
  GoRoute(
    name: 'userDetailsView',
    path: RoutePath.userDetailsView,
    builder: _userDetailsBuilder,
  )
]);
