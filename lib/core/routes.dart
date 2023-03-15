import 'package:go_router/go_router.dart';

import 'package:a3_test/screens/home.dart';
import 'package:a3_test/screens/repositories.dart';
import 'package:a3_test/screens/favorites.dart';

final GoRouter routes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/repositories/:username',
      builder: (context, state) => RepositoriesScreen(state.params['username']),
    ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesScreen(),
    ),
  ],
);
