import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_project/app_routes/route_path.dart';
import 'package:riverpod_project/screens/home_page.dart';
import 'package:riverpod_project/screens/product_detail_page.dart';
import 'package:riverpod_project/screens/user_details_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(navigatorKey: _rootNavigatorKey, routes: [
  GoRoute(
    name: "homeView",
    path: RoutePath.homeView,
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    name: "productDetailsView",
    path: RoutePath.productDetailsView,
    builder: (context, state) {
      var stateExtrasMap = state.extra as Map<String, dynamic>?;
      var prodId = stateExtrasMap?['prodId'];
      return ProductDetailPage(prodId);
    },
  ),
  GoRoute(
    name: 'userDetailsView',
    path: RoutePath.userDetailsView,
    builder: (context, state) {
      var stateExtrasMap = state.extra as Map<String, dynamic>?;
      var userId = stateExtrasMap?['userId'];
      return UserDetailsScreen(userId);
    },
  )
]);
