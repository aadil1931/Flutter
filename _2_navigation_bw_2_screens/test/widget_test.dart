// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:_2_navigation_bw_2_screens/main.dart';

void main() {
  testWidgets('Navigation test between Screen1 and Screen2',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CupertinoApp(
      title: 'Simple Navigation App',
      home: FirstScreen(),
      debugShowCheckedModeBanner: false,
    ));

    // Verify that we are on the FirstScreen.
    expect(find.text('This is Screen1'), findsOneWidget);
    expect(find.text('Goto Screen2'), findsOneWidget);

    // Tap the 'Goto Screen2' button and trigger a frame.
    await tester.tap(find.text('Goto Screen2'));
    await tester.pumpAndSettle();

    // Verify that we are on the SecondScreen.
    expect(find.text('This is Screen1'), findsNothing);
    expect(find.text('This is Screen2'), findsOneWidget);
    expect(find.text('Goto Screen1'), findsOneWidget);

    // Tap the 'Goto Screen1' button and trigger a frame.
    await tester.tap(find.text('Goto Screen1'));
    await tester.pumpAndSettle();

    // Verify that we are back on the FirstScreen.
    expect(find.text('This is Screen1'), findsOneWidget);
    expect(find.text('This is Screen2'), findsNothing);
  });
}
