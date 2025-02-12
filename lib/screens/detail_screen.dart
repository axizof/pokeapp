import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../providers/pokemon_provider.dart';
import '../models/pokemon.dart';

class DetailScreen extends StatelessWidget {
  final String name;
  const DetailScreen({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = context.read<PokemonProvider>();
    final pokemon = pokemonProvider.pokemons.firstWhere(
      (p) => p.name == name,
      orElse:
          () => Pokemon(id: 0, name: 'Inconnu', imageUrl: '', hp: 0, types: []),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          pokemon.name,
        ).animate().fade(duration: 600.ms).slideY(begin: -0.5, end: 0),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              pokemon.imageUrl,
              height: 150,
            ).animate().fade(duration: 500.ms).scale(duration: 400.ms),
            const SizedBox(height: 16),
            Text(
              'Nom : ${pokemon.name}',
              style: const TextStyle(fontSize: 20),
            ).animate().fade(duration: 400.ms).slideX(begin: -0.2, end: 0),
            Text(
              'HP : ${pokemon.hp}',
            ).animate().fade(duration: 400.ms).slideX(begin: 0.2, end: 0),
            Text(
              'Types : ${pokemon.types.join(', ')}',
            ).animate().fade(duration: 400.ms).slideX(begin: -0.2, end: 0),
          ],
        ),
      ),
    );
  }
}
