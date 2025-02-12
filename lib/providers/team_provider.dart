import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import 'dart:math';

class TeamProvider extends ChangeNotifier {
  static const int maxTeamSize = 6;

  final List<Pokemon> _userTeam = [];
  final List<Pokemon> _aiTeam = [];

  List<Pokemon> get userTeam => _userTeam;
  List<Pokemon> get aiTeam => _aiTeam;

  // Génération aléatoire de 6 pokémons pour l’IA
  void generateAiTeam(List<Pokemon> fullList) {
    _aiTeam.clear();
    final random = Random();
    for (int i = 0; i < maxTeamSize; i++) {
      _aiTeam.add(fullList[random.nextInt(fullList.length)]);
    }
    notifyListeners();
  }

  // Ajoute / retire un pokémon de l’équipe user
  void addToUserTeam(Pokemon pokemon) {
    if (_userTeam.length < maxTeamSize && !_userTeam.contains(pokemon)) {
      _userTeam.add(pokemon);
      notifyListeners();
    }
  }

  void removeFromUserTeam(Pokemon pokemon) {
    _userTeam.remove(pokemon);
    notifyListeners();
  }

  // Vérifie si le Pokémon est déjà dans l’équipe utilisateur
  bool isInUserTeam(Pokemon pokemon) => _userTeam.contains(pokemon);
}