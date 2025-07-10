import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hahhhahaha/main.dart'; // Make sure the package name is correct

void main() {
  testWidgets('Transposes chords on button press', (WidgetTester tester) async {
    // Launch the app
    await tester.pumpWidget(ChordTransposerApp());

    // Enter some chords in the text field
    final inputField = find.byType(TextField);
    expect(inputField, findsOneWidget);
    await tester.enterText(inputField, 'C G Am F');

    // Tap the '+' button to shift semitones up
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Expect the transposed output to include 'D A Bm G'
    expect(find.textContaining('D A Bm G'), findsOneWidget);
  });
}
