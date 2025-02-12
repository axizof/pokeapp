import 'package:dio/dio.dart';
import '../models/pokemon.dart';

class PokemonService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2'));

  // Récupére la liste des pokémons (limite à 151)
  Future<List<Pokemon>> fetchPokemons({int limit = 151}) async {
    final response = await _dio.get('/pokemon?limit=$limit');
    final results = response.data['results'] as List;

    // Chaque résultat contient un name et un url, fetch les détails de chaque Pokémon pour avoir ses stats / images
    List<Pokemon> pokemons = [];
    for (var item in results) {
      final pokemonDetails = await _dio.get(item['url']);
      pokemons.add(Pokemon.fromJson(pokemonDetails.data));
    }
    return pokemons;
  }

  // Récupére un Pokémon en particulier
  Future<Pokemon> fetchPokemonByName(String name) async {
    final response = await _dio.get('/pokemon/$name');
    return Pokemon.fromJson(response.data);
  }
}
