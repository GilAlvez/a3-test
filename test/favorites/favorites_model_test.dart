import 'package:a3_test/app/favorites/favorites_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Favorite Model', () {
    test('fromJson should creates a valid Favorite object from json', () {
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

    test('toJson should return a valid JSON representation of a Favorite object', () {
      final Favorite favoriteObject = Favorite(
        id: 1,
        name: 'Test',
        url: 'https://example.com',
      );

      final Map<String, dynamic> favoriteJson = favoriteObject.toJson();

      expect(favoriteJson['id'], 1);
      expect(favoriteJson['name'], 'Test');
      expect(favoriteJson['url'], 'https://example.com');
    });
  });
}
