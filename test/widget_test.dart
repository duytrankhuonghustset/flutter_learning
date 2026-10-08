import 'package:flutter/material.dart';
import 'package:flutter_learning/screens/counter_home_page.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('Counter tăng, không âm, reset', (WidgetTester tester) async {
    await tester.pumpWidget(const CounterHomePage());

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);

    // Nút giảm disabled khi = 0 — tap không làm số âm.
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);
    expect(find.text('-1'), findsNothing);
  });
}
