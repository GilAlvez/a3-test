import 'package:a3_test/app/repositories/widgets/favorite_badge.dart';
import 'package:flutter/material.dart';
import 'package:go_router_flow/go_router_flow.dart';

import 'package:a3_test/app/repositories/widgets/repositories_list.dart';

class RepositoriesPage extends StatelessWidget {
  const RepositoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Repositories'),
        actions: [
          FavoriteBadge(
            child: IconButton(
              onPressed: () => context.go('/favorites'),
              icon: const Icon(Icons.favorite_border),
              splashRadius: 24,
            ),
          )
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(12.0),
        child: RepositoriesList(),
      ),
    );
  }
}
