import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:a3_test/app/favorites/favorites_model.dart';

class FavoritesController {
  static const String _favoriteRepositoriesKey = 'fav_repo_prefs';

  Future<List<Favorite>> getFavoriteRepositories() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteRepositories = prefs.getStringList(_favoriteRepositoriesKey) ?? [];

    return favoriteRepositories.map((repo) => Favorite.fromJson(jsonDecode(repo))).toList();
  }

  Future<void> addFavoriteRepository(int id, String name, String url) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteRepositories = prefs.getStringList(_favoriteRepositoriesKey) ?? [];

    final newRepo = Favorite(id: id, name: name, url: url);
    favoriteRepositories.add(jsonEncode(newRepo.toJson()));

    await prefs.setStringList(_favoriteRepositoriesKey, favoriteRepositories);
  }

  Future<void> removeFavoriteRepository(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteRepositories = prefs.getStringList(_favoriteRepositoriesKey) ?? [];

    favoriteRepositories.removeWhere((repo) => Favorite.fromJson(jsonDecode(repo)).id == id);

    await prefs.setStringList(_favoriteRepositoriesKey, favoriteRepositories);
  }
}
