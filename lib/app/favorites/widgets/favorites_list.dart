import 'package:a3_test/app/favorites/favorites_controller.dart';
import 'package:a3_test/app/favorites/favorites_model.dart';
import 'package:flutter/material.dart';

class FavoritesList extends StatefulWidget {
  const FavoritesList({super.key});

  @override
  State<FavoritesList> createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  late List<Favorite> favorites = [];

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
    return await FavoritesController().getFavoriteRepositories();
  }

  void removeFavorites(int id) async {
    await FavoritesController().removeFavoriteRepository(id);
    setState(() {
      favorites.removeWhere((repo) => repo.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.separated(
        itemCount: favorites.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final repository = favorites[index];
          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              title: Text(repository.name),
              subtitle: Text(repository.url),
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
