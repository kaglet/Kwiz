import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwiz/pages/home.dart';
import 'package:kwiz/pages/add_quiz_about.dart';
import 'package:kwiz/view_categories.dart';

void main() {
  testWidgets('Home screen buttons', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Home()));

    expect(find.text('Browse our quizzes'), findsOneWidget);
    expect(find.text('Add custom quiz'), findsOneWidget);

    await tester.tap(find.text('Browse our quizzes'));
    await tester.pumpAndSettle();
    expect(find.byType(ViewCategories), findsOneWidget);

    await tester.tap(find.text('Add custom quiz'));
    await tester.pumpAndSettle();
    expect(find.byType(AddQuiz), findsOneWidget);
  });
}
