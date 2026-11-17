import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final state = GoRouterState.of(context);
    final path = state.uri.path;
    final filter = state.uri.queryParameters['filter'];

    return Scaffold(
      appBar: AppBar(
        title: Text(_title(path)),
        centerTitle: path != '/taches',
      ),
      body: child,
      floatingActionButton: path == '/taches'
          ? FloatingActionButton(
              onPressed: () => context.go('/taches/nouvelle'),
              tooltip: 'Nouvelle tâche',
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _destinationIndex(path, filter),
        onDestinationSelected: (index) => _goTo(context, index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment),
            label: 'À faire',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_circle_outline),
            selectedIcon: Icon(Icons.check_circle),
            label: 'Faites',
          ),
          NavigationDestination(
            icon: Icon(Icons.warning_amber_outlined),
            selectedIcon: Icon(Icons.warning_amber),
            label: 'En retard',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Cours',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  int _destinationIndex(String path, String? filter) {
    if (path == '/cours') {
      return 3;
    }
    if (path == '/profil') {
      return 4;
    }
    if (filter == 'faites') {
      return 1;
    }
    if (filter == 'enRetard') {
      return 2;
    }
    return 0;
  }

  String _title(String path) {
    if (path == '/taches/nouvelle') {
      return 'Nouvelle tâche';
    }
    if (path.startsWith('/taches/')) {
      return 'Tâche';
    }
    if (path == '/cours') {
      return 'Cours';
    }
    if (path == '/profil') {
      return 'Profil';
    }
    return 'CampusFlow';
  }

  void _goTo(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/taches?filter=aFaire');
      case 1:
        context.go('/taches?filter=faites');
      case 2:
        context.go('/taches?filter=enRetard');
      case 3:
        context.go('/cours');
      case 4:
        context.go('/profil');
    }
  }
}
