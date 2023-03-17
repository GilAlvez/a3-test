import 'package:flutter/material.dart';

import 'package:a3_test/app/favorites/widgets/favorites_list.dart';
import 'package:go_router_flow/go_router_flow.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
          leading: IconButton(
            onPressed: () {
              context.pushReplacement('/');
            },
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Back',
          ),
        ),
        body: const FavoritesList());
  }
}
