import 'package:flutter_test/flutter_test.dart';
import 'package:a3_test/app/repositories/repositories_model.dart';

void main() {
  group('Repository Model', () {
    test('fromJson should creates a valid Repository object from json', () {
      final json = {
        'id': 1,
        'name': 'Test Repository',
        'description': 'A test repository',
        'html_url': 'https://github.com/test/test-repo',
        'stargazers_count': 10,
        'language': 'Dart',
        'created_at': '2022-03-02T00:00:00Z'
      };

      final repository = Repository.fromJson(json);

      expect(repository.id, 1);
      expect(repository.name, 'Test Repository');
      expect(repository.description, 'A test repository');
      expect(repository.url, 'https://github.com/test/test-repo');
      expect(repository.stars, 10);
      expect(repository.language, 'Dart');
      expect(repository.createdAt, '2022-03-02T00:00:00Z');
    });

    test('toJson should return a valid JSON representation of a Repository object', () {
      final repository = Repository(
          id: 1,
          name: 'Test Repository',
          description: 'A test repository',
          url: 'https://github.com/test/test-repo',
          stars: 10,
          language: 'Dart',
          createdAt: '2022-03-02T00:00:00Z');

      final json = repository.toJson();

      expect(json['id'], 1);
      expect(json['name'], 'Test Repository');
      expect(json['description'], 'A test repository');
      expect(json['html_url'], 'https://github.com/test/test-repo');
      expect(json['stargazers_count'], 10);
      expect(json['language'], 'Dart');
      expect(json['created_at'], '2022-03-02T00:00:00Z');
    });
  });

  test('fromJson should have treatment for null values', () {
    final json = {
      'id': 1,
      'name': 'Test Repository',
      'description': null,
      'html_url': 'https://github.com/test/test-repo',
      'stargazers_count': 10,
      'language': null,
      'created_at': '2022-03-02T00:00:00Z'
    };

    final repository = Repository.fromJson(json);

    expect(repository.description, '');
    expect(repository.language, 'Unknown');
  });
}
