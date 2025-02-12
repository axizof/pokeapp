import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'screens/master_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/team_screen.dart';
import 'screens/battle_screen.dart';

import 'providers/pokemon_provider.dart';
import 'providers/team_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PokemonProvider()..loadPokemons(),
        ),
        ChangeNotifierProvider(create: (_) => TeamProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const MasterScreen()),
      GoRoute(
        path: '/detail/:name',
        builder: (context, state) {
          final name = state.pathParameters['name']!;
          return DetailScreen(name: name);
        },
      ),
      GoRoute(path: '/team', builder: (context, state) => const TeamScreen()),
      GoRoute(
        path: '/battle',
        builder: (context, state) => const BattleScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PokéFlutter TCG',
      theme: ThemeData(
        primarySwatch: Colors.red,
        // Intégration d’une police Google Fonts par exemple
        fontFamily: 'Montserrat', // si vous l’avez ajoutée
      ),
      routerConfig: _router,
    );
  }
}
