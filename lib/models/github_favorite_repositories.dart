import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Favorite {
  final int id;
  final String name;
  final String url;

  Favorite({
    required this.id,
    required this.name,
    required this.url,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['id'],
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
    };
  }
}

class GitHubFavoriteRepository {
  static const String _favoriteRepositories = 'fav_repo_prefs';

  Future<List<Favorite>> getFavoriteRepositories() async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteRepos = prefs.getStringList(_favoriteRepositories) ?? [];

    return favoriteRepos.map((repo) => Favorite.fromJson(jsonDecode(repo))).toList();
  }

  Future<void> addFavoriteRepository(int id, String name, String url) async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteRepos = prefs.getStringList(_favoriteRepositories) ?? [];

    final newRepo = Favorite(id: id, name: name, url: url);

    favoriteRepos.add(jsonEncode(newRepo.toJson()));

    await prefs.setStringList(_favoriteRepositories, favoriteRepos);
  }

  Future<void> removeFavoriteRepository(int id) async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteRepos = prefs.getStringList(_favoriteRepositories) ?? [];

    favoriteRepos.removeWhere((repo) => Favorite.fromJson(jsonDecode(repo)).id == id);

    await prefs.setStringList(_favoriteRepositories, favoriteRepos);
  }
}
