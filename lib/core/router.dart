import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../screens/cours_screen.dart';
import '../screens/login_screen.dart';
import '../screens/profil_screen.dart';
import '../screens/tache_detail_screen.dart';
import '../screens/tache_form_screen.dart';
import '../screens/taches_screen.dart';
import '../state/filters.dart';
import '../state/providers.dart';
import '../widgets/main_shell.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final connected = ref.watch(tokenProvider) != null;

  return GoRouter(
    initialLocation: '/taches',
    redirect: (context, state) {
      final onLogin = state.matchedLocation == '/login';
      if (!connected && !onLogin) {
        return '/login';
      }
      if (connected && onLogin) {
        return '/taches';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: '/taches',
            builder: (context, state) =>
                TachesScreen(filter: filterFromState(state)),
            routes: [
              GoRoute(
                path: 'nouvelle',
                builder: (context, state) => const TacheFormScreen(),
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) => TacheDetailScreen(
                  id: int.parse(state.pathParameters['id']!),
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/cours',
            builder: (context, state) => const CoursScreen(),
          ),
          GoRoute(
            path: '/profil',
            builder: (context, state) => const ProfilScreen(),
          ),
        ],
      ),
    ],
  );
});

TaskFilter filterFromState(GoRouterState state) {
  return switch (state.uri.queryParameters['filter']) {
    'faites' => TaskFilter.faites,
    'enRetard' => TaskFilter.enRetard,
    _ => TaskFilter.aFaire,
  };
}
