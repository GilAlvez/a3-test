import 'package:a3_test/app/favorites/favorites_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Favorite Provider', () {
    late FavoritesProvider provider;
    setUp(() => provider = FavoritesProvider());

    test('favorites list should init empty', () {
      expect(provider.favorites, isEmpty);
    });

    testWidgets('toggleFavorites should add or remove items from list', (WidgetTester tester) async {
      provider.toggleFavorites(1, 'Test1', 'https://example.com');
      provider.toggleFavorites(2, 'Test2', 'https://example.com');

      expect(provider.favorites, hasLength(equals(2)));

      provider.toggleFavorites(1, 'Test1', 'https://example.com');
      provider.toggleFavorites(2, 'Test2', 'https://example.com');

      expect(provider.favorites, hasLength(equals(0)));
    });

    testWidgets('removeFavorites should remove items with id only', (WidgetTester tester) async {
      provider.toggleFavorites(1, 'Test1', 'https://example.com');
      provider.toggleFavorites(2, 'Test2', 'https://example.com');

      expect(provider.favorites, hasLength(equals(2)));

      provider.removeFavorites(1);
      provider.removeFavorites(2);

      expect(provider.favorites, hasLength(equals(0)));
    });

    testWidgets('removeFavorites should not remove if id doesnt exist', (WidgetTester tester) async {
      provider.toggleFavorites(1, 'Test1', 'https://example.com');
      provider.toggleFavorites(2, 'Test2', 'https://example.com');

      expect(provider.favorites, hasLength(equals(2)));

      provider.removeFavorites(3);
      provider.removeFavorites(4);

      expect(provider.favorites, hasLength(equals(2)));
    });
  });
}
