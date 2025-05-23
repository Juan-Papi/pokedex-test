import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/features/explore-pokemon/presentation/screens/explorer_screen.dart';
import 'package:pokedex/features/explore-pokemon/presentation/screens/home_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/explore',
        builder: (context, state) => const ExplorerScreen(),
      ),
    ],
  );
});
