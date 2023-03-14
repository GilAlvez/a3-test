import 'package:flutter_test/flutter_test.dart';
import 'package:a3_test/main.dart';

void main() {
  testWidgets('Initial test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('A3Test'), findsOneWidget);
  });
}
