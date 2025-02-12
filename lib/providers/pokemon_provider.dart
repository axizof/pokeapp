import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../services/pokemon_service.dart';

class PokemonProvider extends ChangeNotifier {
  final PokemonService _service = PokemonService();

  List<Pokemon> _pokemons = [];
  bool _isLoading = false;

  List<Pokemon> get pokemons => _pokemons;
  bool get isLoading => _isLoading;

  Future<void> loadPokemons() async {
    _isLoading = true;
    notifyListeners();

    _pokemons = await _service.fetchPokemons(limit: 151);

    _isLoading = false;
    notifyListeners();
  }
}