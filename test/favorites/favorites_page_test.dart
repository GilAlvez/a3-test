import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:a3_test/app/favorites/widgets/favorites_list.dart';
import 'package:a3_test/app/favorites/favorites_page.dart';

void main() {
  group('Favorites Page', () {
    testWidgets('should display a list of favorite items', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: FavoritesPage(),
        ),
      );

      expect(find.text('Favorites'), findsOneWidget);

      expect(find.byIcon(Icons.arrow_back), findsOneWidget);

      expect(find.byType(FavoritesList), findsOneWidget);
    });
  });
}
