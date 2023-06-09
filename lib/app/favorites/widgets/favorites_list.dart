import 'package:a3_test/app/favorites/favorites_controller.dart';
import 'package:a3_test/app/favorites/favorites_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoritesList extends StatefulWidget {
  const FavoritesList({super.key});

  @override
  State<FavoritesList> createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  late List<Favorite> favorites = [];
  final controller = FavoritesController();

  @override
  void initState() {
    super.initState();
    loadFavorites().then((value) {
      setState(() {
        favorites = value;
      });
    });
  }

  Future<List<Favorite>> loadFavorites() async {
    return await controller.getFavoriteRepositories();
  }

  void removeFavorites(int id) async {
    await controller.removeFavoriteRepository(id);
    setState(() {
      favorites.removeWhere((repo) => repo.id == id);
    });
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'You don\'t have any favorited repository',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.go('/'),
                    child: const Text('Back'),
                  )
                ],
              ),
            )
          : ListView.separated(
              itemCount: favorites.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final repository = favorites[index];
                return Card(
                  child: ListTile(
                    onTap: () => _launchUrl(Uri.parse(repository.url)),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    title: Text(repository.name),
                    subtitle: Text(
                      repository.url,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      onPressed: () => removeFavorites(repository.id),
                      icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                      splashRadius: 24,
                      splashColor: Colors.red.shade50,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
