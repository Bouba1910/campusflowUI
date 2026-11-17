import 'package:campusflow/app.dart';
import 'package:campusflow/core/secure_token_storage.dart';
import 'package:campusflow/data/fake_task_repository.dart';
import 'package:campusflow/state/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget buildApp(FakeTaskRepository repository) {
  return ProviderScope(
    overrides: [
      tokenProvider.overrideWith(() => TokenNotifier('token-demo')),
      secureTokenStorageProvider.overrideWithValue(_FakeTokenStorage()),
      taskRepositoryProvider.overrideWithValue(repository),
    ],
    child: const CampusFlowApp(),
  );
}

class _FakeTokenStorage extends SecureTokenStorage {
  @override
  Future<String?> readToken() async => 'token-demo';

  @override
  Future<void> saveToken(String token) async {}

  @override
  Future<void> clearToken() async {}
}

void main() {
  testWidgets('affiche la liste des tâches', (tester) async {
    await tester.pumpWidget(buildApp(FakeTaskRepository()));
    await tester.pumpAndSettle();

    expect(find.text('CampusFlow'), findsOneWidget);
    expect(find.text('Rendre le TP Flutter'), findsOneWidget);
  });

  testWidgets('ouvre le détail et marque la tâche comme faite', (tester) async {
    await tester.pumpWidget(buildApp(FakeTaskRepository()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Rendre le TP Flutter'));
    await tester.pumpAndSettle();

    expect(find.text('Marquer comme fait'), findsOneWidget);

    await tester.tap(find.text('Marquer comme fait'));
    await tester.pumpAndSettle();

    expect(find.text('Tâche terminée'), findsOneWidget);
  });

  testWidgets('filtre les tâches terminées', (tester) async {
    await tester.pumpWidget(buildApp(FakeTaskRepository()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Faites'));
    await tester.pumpAndSettle();

    expect(find.text('Rendre le compte rendu'), findsOneWidget);
    expect(find.text('Rendre le TP Flutter'), findsNothing);
  });

  testWidgets('affiche la liste et le détail côte à côte sur tablette', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1000, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildApp(FakeTaskRepository()));
    await tester.pumpAndSettle();

    expect(find.text('Aucune tâche sélectionnée.'), findsOneWidget);

    await tester.tap(find.text('Rendre le TP Flutter'));
    await tester.pumpAndSettle();

    expect(find.text('Rendre le TP Flutter'), findsNWidgets(2));
    expect(find.text('Marquer comme fait'), findsOneWidget);
  });
}
