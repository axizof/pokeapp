import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../providers/team_provider.dart';
import '../providers/pokemon_provider.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final teamProvider = context.watch<TeamProvider>();
    final pokemonProvider = context.read<PokemonProvider>();

    final userTeam = teamProvider.userTeam;
    final aiTeam = teamProvider.aiTeam;

    return Scaffold(
      appBar: AppBar(title: const Text('Équipes')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Ton équipe :', style: TextStyle(fontSize: 18)),
            Wrap(
              spacing: 8,
              children: userTeam.map((p) => Chip(label: Text(p.name))).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Génération aléatoire de l’équipe AI
                teamProvider.generateAiTeam(pokemonProvider.pokemons);
              },
              child: const Text("Générer l'équipe AI"),
            ),
            const SizedBox(height: 16),
            const Text('Équipe de l’AI :', style: TextStyle(fontSize: 18)),
            Wrap(
              spacing: 8,
              children: aiTeam.map((p) => Chip(label: Text(p.name))).toList(),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed:
                  userTeam.isNotEmpty && aiTeam.isNotEmpty
                      ? () => context.push('/battle')
                      : null,
              child: const Text('Démarrer le combat'),
            ),
          ],
        ),
      ),
    );
  }
}
