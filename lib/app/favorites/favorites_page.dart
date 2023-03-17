import 'package:flutter/material.dart';

import 'package:a3_test/app/favorites/widgets/favorites_list.dart';
import 'package:go_router_flow/go_router_flow.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final route = GoRouter.of(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
          leading: IconButton(
            onPressed: () {
              route.go('/');
            },
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Back',
          ),
        ),
        body: const FavoritesList());
  }
}
