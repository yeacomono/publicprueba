import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tennis_court_agend/Pages/Agend/agend.dart';

void main() {
  testWidgets('ReserverCourt Widget should build', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: ReserverCourt(),
      ),
    );

    // Verify that the widget is built.
    expect(find.text('Reserved Tennis Court'), findsOneWidget);
    expect(find.text('Who is reserving this court?'), findsOneWidget);
  });
}