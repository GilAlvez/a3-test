import 'package:a3_test/app/favorites/favorites_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Favorite', () {
    test('fromJson should return a valid Favorite instance', () {
      final Map<String, dynamic> json = {
        'id': 1,
        'name': 'Test',
        'url': 'https://example.com',
      };

      final Favorite favorite = Favorite.fromJson(json);

      expect(favorite, const TypeMatcher<Favorite>());
      expect(favorite.id, equals(1));
      expect(favorite.name, equals('Test'));
      expect(favorite.url, equals('https://example.com'));
    });

    test('toJson should return a valid Map', () {
      final Map<String, dynamic> json = {
        'id': 1,
        'name': 'Test',
        'url': 'https://example.com',
      };

      final Favorite favorite = Favorite.fromJson(json);
      final Map<String, dynamic> favoriteJson = favorite.toJson();

      expect(favoriteJson, equals(json));
    });
  });
}
