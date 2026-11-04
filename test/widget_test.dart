import 'package:campusflow/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('affiche la liste et ouvre le détail', (tester) async {
    await tester.pumpWidget(const CampusFlowApp());

    expect(find.text('CampusFlow'), findsOneWidget);
    expect(find.text('Rendre le TP Flutter'), findsOneWidget);

    await tester.tap(find.text('Rendre le TP Flutter'));
    await tester.pumpAndSettle();

    expect(find.text('Échéance'), findsOneWidget);
    expect(find.text('Marquer comme faite'), findsOneWidget);
  });

  testWidgets('marque une échéance comme faite', (tester) async {
    await tester.pumpWidget(const CampusFlowApp());

    await tester.tap(find.text('Rendre le TP Flutter'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Marquer comme faite'));
    await tester.pumpAndSettle();

    expect(find.text('Échéance terminée'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Rendre le TP Flutter'), findsNothing);
  });

  testWidgets('affiche la liste et le détail côte à côte sur tablette', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1000, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const CampusFlowApp());

    expect(find.text('Aucune échéance sélectionnée.'), findsOneWidget);
    expect(find.text('Réviser les widgets'), findsOneWidget);

    await tester.tap(find.text('Rendre le TP Flutter'));
    await tester.pumpAndSettle();

    expect(find.text('Rendre le TP Flutter'), findsNWidgets(2));
    expect(find.text('Réviser les widgets'), findsOneWidget);
    expect(find.text('Marquer comme faite'), findsOneWidget);
  });
}
