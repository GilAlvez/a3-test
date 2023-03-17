import 'package:a3_test/app/favorites/favorites_controller.dart';
import 'package:flutter/material.dart';

import 'package:a3_test/app/favorites/favorites_model.dart';

class FavoritesProvider extends ChangeNotifier {
  List<Favorite> _favorites = [];

  List<Favorite> get favorites => _favorites;

  Future<void> loadFavorites() async {
    final repositories = await FavoritesController().getFavoriteRepositories();
    _favorites = repositories;
    notifyListeners();
  }

  void toggleFavorites(int id, String name, String url) async {
    final index = _favorites.indexWhere((repo) => repo.id == id);

    if (index >= 0) {
      _favorites.removeAt(index);
      await FavoritesController().removeFavoriteRepository(id);
    } else {
      _favorites.add(Favorite(id: id, name: name, url: url));
      await FavoritesController().addFavoriteRepository(id, name, url);
    }
    notifyListeners();
  }

  void removeFavorites(int id) async {
    await FavoritesController().removeFavoriteRepository(id);
    _favorites.removeWhere((repo) => repo.id == id);

    notifyListeners();
  }
}
