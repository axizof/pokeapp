import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart'; // <-- import flutter_animate

import '../providers/pokemon_provider.dart';
import '../providers/team_provider.dart';

class MasterScreen extends StatelessWidget {
  const MasterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = context.watch<PokemonProvider>();
    final teamProvider = context.watch<TeamProvider>();

    if (pokemonProvider.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final pokemons = pokemonProvider.pokemons;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex')
            .animate()
            .tint(color: Colors.red)
            .fade(delay: 300.ms, duration: 600.ms)
            .effect()
            .shake(delay: 300.ms, duration: 600.ms)
            .slideY(begin: -0.5, end: 0),
        actions: [
          IconButton(
            icon: const Icon(Icons.group),
            onPressed: () {
              context.push('/team');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: pokemons.length,
        itemBuilder: (context, index) {
          final pokemon = pokemons[index];
          final isSelected = teamProvider.isInUserTeam(pokemon);

          return ListTile(
                leading: Image.network(pokemon.imageUrl),
                title: Text(pokemon.name),
                subtitle: Text(
                  'HP: ${pokemon.hp}  -  Types: ${pokemon.types.join(', ')}',
                ),
                tileColor: isSelected ? Colors.yellow[100] : null,
                onTap: () {
                  context.push('/detail/${pokemon.name}');
                },
                trailing: IconButton(
                  icon: Icon(
                    isSelected ? Icons.remove_circle : Icons.add_circle,
                    color: isSelected ? Colors.red : Colors.green,
                  ),
                  onPressed: () {
                    if (!isSelected) {
                      teamProvider.addToUserTeam(pokemon);
                    } else {
                      teamProvider.removeFromUserTeam(pokemon);
                    }
                  },
                ),
              )
              .animate()
              .fade(duration: 400.ms)
              .slideX(begin: -0.3, duration: 400.ms, curve: Curves.easeOutQuad)
              // scale "léger" :
              .then()
              .scaleXY(end: 1.02, duration: 200.ms)
              .then()
              .scaleXY(end: 1.0, duration: 200.ms);
        },
      ),
    );
  }
}
