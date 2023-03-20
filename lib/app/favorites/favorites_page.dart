import 'package:flutter/material.dart';
import 'package:go_router_flow/go_router_flow.dart';

import 'package:a3_test/app/favorites/widgets/favorites_list.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        leading: IconButton(
          onPressed: () {
            context.go('/');
          },
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),
      ),
      body: const FavoritesList(),
    );
  }
}
