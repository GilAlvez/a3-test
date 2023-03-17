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
      String message = '';

      switch (response.statusCode) {
        case 403:
          message =
              'You do not have permission to access this resource. It might be due to multiple requests. Please try refreshing or try again later.';
          break;
        case 404:
          message = 'The resource you are trying to access was not found.';
          break;
        case 500:
          message = 'The server encountered an unexpected error.';
          break;
        default:
          message = 'An error occurred.';
      }
      throw message;
    }

    return [];
  }
}
