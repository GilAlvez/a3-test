import 'package:go_router/go_router.dart';
import 'package:a3_test/screens/home.dart';

final GoRouter routes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    // GoRoute(
    //   path: '/repositories',
    //   builder: (context, state) => const RepositoriesScreen(),
    // ),
    // GoRoute(
    //   path: '/repositories/favorite',
    //   builder: (context, state) => const RepositoriesFavoriteScreen(),
    // ),
  ],
);
