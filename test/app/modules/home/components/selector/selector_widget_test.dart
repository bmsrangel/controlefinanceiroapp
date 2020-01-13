import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:controlefinanceiroapp/app/modules/home/components/selector/selector_widget.dart';

main() {
  testWidgets('SelectorWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(SelectorWidget()));
    final textFinder = find.text('Selector');
    expect(textFinder, findsOneWidget);
  });
}
