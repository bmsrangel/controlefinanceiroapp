import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:controlefinanceiroapp/app/modules/home/components/movimentations/movimentations_widget.dart';

main() {
  testWidgets('MovimentationsWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(MovimentationsWidget()));
    final textFinder = find.text('Movimentations');
    expect(textFinder, findsOneWidget);
  });
}
