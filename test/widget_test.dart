// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase/models/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:firebase/main.dart';

void main() {
  test('serializes and restores a task from firestore data', () {
    final task = Task(
      'Plan sprint review',
      'Confirm dependencies for the next sprint',
      '2:30 PM',
      'Work',
      Priority.medium,
      id: 'abc123',
      date: 'Oct 1, 2026',
      completed: true,
    );

    final map = task.toMap();
    final restored = Task.fromMap(map..['id'] = 'abc123');

    expect(map['title'], 'Plan sprint review');
    expect(map['priority'], 'medium');
    expect(map['date'], 'Oct 1, 2026');
    expect(restored.title, 'Plan sprint review');
    expect(restored.id, 'abc123');
    expect(restored.date, 'Oct 1, 2026');
    expect(restored.completed, isTrue);
  });

  testWidgets('opens task details and updates the existing task', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Good morning, Sarah'), findsOneWidget);
    expect(find.text('Finalize Q3 Design System tokens'), findsOneWidget);

    await tester.tap(find.text('Finalize Q3 Design System tokens'));
    await tester.pumpAndSettle();

    expect(find.text('Task Details'), findsOneWidget);
    expect(find.text('Update Task'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextField, 'Finalize Q3 Design System tokens'),
      'Updated design tokens task',
    );
    await tester.tap(find.text('Update Task'));
    await tester.pumpAndSettle();

    expect(find.text('Updated design tokens task'), findsOneWidget);
  });

  testWidgets('creates a task from the add task flow', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Add Task'));
    await tester.pumpAndSettle();
    expect(find.text('New Task'), findsWidgets);

    await tester.enterText(find.byType(TextField).first, 'Plan sprint review');
    await tester.scrollUntilVisible(
      find.text('Save Task'),
      500,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Save Task'));
    await tester.pumpAndSettle();

    expect(find.text('Plan sprint review'), findsOneWidget);
  });
}
