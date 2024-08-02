import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_project/app_routes/route_path.dart';
import 'package:riverpod_project/screens/home_page.dart';
import 'package:riverpod_project/screens/product_detail_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(navigatorKey: _rootNavigatorKey, routes: [
  GoRoute(
    name: "homeView",
    parentNavigatorKey: _rootNavigatorKey,
    path: RoutePath.homeView,
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    name: "productDetailsView",
    parentNavigatorKey: _rootNavigatorKey,
    path: RoutePath.productDetailsView,
    builder: (context, state) {
      var stateWithProductId = state.extra as Map<String, dynamic>?;
      var prodId = stateWithProductId?['prodId'];
      return ProductDetailPage(prodId);
    },
  ),
]);
