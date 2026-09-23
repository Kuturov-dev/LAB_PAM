import 'package:flutter_test/flutter_test.dart';
import 'package:fitness_app/main.dart';

void main() {
  testWidgets('Renders FitnessApp and Home elements', (WidgetTester tester) async {
    await tester.pumpWidget(const FitnessApp());

    expect(find.text('Good Morning'), findsOneWidget);
    expect(find.text("Today's Challenge"), findsOneWidget);
    expect(find.text('Featured Plan'), findsOneWidget);
    expect(find.text('Workout Programs'), findsOneWidget);
  });
}
