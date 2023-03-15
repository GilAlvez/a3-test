import 'package:flutter/material.dart';

import 'package:a3_test/models/github_favorite_repositories.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Favorite> _repositories = [];

  @override
  void initState() {
    super.initState();
    _loadRepositories();
  }

  Future<void> _loadRepositories() async {
    final repositories = await GitHubFavoriteRepository().getFavoriteRepositories();
    setState(() {
      _repositories = repositories;
    });
  }

  // Future<void> _addRepository(int id, String name, String url) async {
  //   await GitHubFavoriteRepository().addFavoriteRepository(id, name, url);
  //   setState(() {
  //     _repositories.add(Favorite(id: id, name: name, url: url));
  //   });
  // }

  Future<void> _removeRepository(int id) async {
    await GitHubFavoriteRepository().removeFavoriteRepository(id);
    setState(() {
      _repositories.removeWhere((repo) => repo.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.separated(
            itemCount: _repositories.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final repository = _repositories[index];
              return Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  title: Text(repository.name),
                  subtitle: Text(repository.url),
                  trailing: IconButton(
                    onPressed: () => _removeRepository(repository.id),
                    icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                    splashRadius: 24,
                    splashColor: Colors.red.shade50,
                  ),
                ),
              );
            },
          ),
        ));
  }
}
