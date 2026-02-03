import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hitch_db/main.dart';

void main() {
  testWidgets('HomePage displays title Hitch DB', (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp());
    expect(find.text('Hitch DB'), findsOneWidget);
  });
}
