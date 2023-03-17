import 'package:a3_test/app/favorites/favorites_provider.dart';
import 'package:a3_test/app/repositories/widgets/favorite_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  group('Favorite Badge widget', () {
    testWidgets('should display the number of favorites', (WidgetTester tester) async {
      final provider = FavoritesProvider();
      provider.toggleFavorites(1, 'name1', 'url1');
      provider.toggleFavorites(2, 'name2', 'url2');

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (_) => provider,
            child: const FavoriteBadge(child: Placeholder()),
          ),
        ),
      );

      final badgeLabelFinder = find.text('2');
      expect(badgeLabelFinder, findsOneWidget);
    });
  });
}
