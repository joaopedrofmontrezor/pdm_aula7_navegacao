

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pdm_aula7_navegacao/main.dart';

void main() {
  testWidgets('Contador incrementa e decrementa corretamente', (WidgetTester tester) async {
   
    await tester.pumpWidget(const MeuApp());

    
    expect(find.text('1'), findsOneWidget);
    expect(find.text('2'), findsNothing);

    
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    
    expect(find.text('1'), findsNothing);
    expect(find.text('2'), findsOneWidget);

    
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();

    expect(find.text('2'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Botão Zerar Contador reseta a quantidade para 1', (WidgetTester tester) async {
    await tester.pumpWidget(const MeuApp());

    
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('3'), findsOneWidget);

    await tester.tap(find.text('Zerar Contador'));
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
  });
}