import 'package:flutter_test/flutter_test.dart';
import 'package:fitness_app/main.dart';

void main() {
  testWidgets('Renders FitnessApp successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const FitnessApp());
    expect(find.byType(FitnessApp), findsOneWidget);
  });
}
