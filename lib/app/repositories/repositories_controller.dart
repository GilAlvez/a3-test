import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:a3_test/app/repositories/repositories_model.dart';

class RepositoriesController {
  static const String _baseUrl = 'api.github.com';

  Future<List<Repository>> getFlutterRepositories() async {
    final response = await http.get(Uri.https(_baseUrl, '/users/flutter/repos'));

    if (response.statusCode == 200) {
      final List<dynamic> repositoriesJson = jsonDecode(response.body);
      final List<Repository> repositories =
          repositoriesJson.map((repository) => Repository.fromJson(repository)).toList();
      return repositories;
    }

    if (response.statusCode >= 400) {
      throw Exception('Failed to load repositories. Status code: ${response.statusCode}');
    }

    return [];
  }
}
