import 'package:go_router_flow/go_router_flow.dart';

import 'package:a3_test/app/favorites/favorites_page.dart';
import 'package:a3_test/app/repositories/repositories_page.dart';

final GoRouter routes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const RepositoriesPage(),
    ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesPage(),
    ),
  ],
);
