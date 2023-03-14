import 'dart:convert';

import 'package:http/http.dart' as http;

class GithubRepository {
  final String baseUrl = 'api.github.com';

  Future<List<Map<String, dynamic>>> getRepositoriesFromUser(String user) async {
    final response = await http.get(Uri.https(baseUrl, '/users/$user/repos'));

    if (response.statusCode == 200) {
      final List<dynamic> repositoriesJson = jsonDecode(response.body);
      final List<Map<String, dynamic>> repositories =
          repositoriesJson.map((repository) => repository as Map<String, dynamic>).toList();

      return repositories;
    }

    if (response.statusCode >= 400) {
      throw Exception('Failed to load repositories. Status code: ${response.statusCode}');
    }

    return [];
  }
}
