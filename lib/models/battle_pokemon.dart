import 'dart:math';

class BattlePokemon {
  final String name;
  int currentHp;
  final int minAttack;
  final int maxAttack;

  BattlePokemon({
    required this.name,
    required this.currentHp,
    this.minAttack = 5,
    this.maxAttack = 20,
  });

  // Attaque aléatoire entre minAttack et maxAttack
  int attackDamage() {
    return Random().nextInt(maxAttack - minAttack + 1) + minAttack;
  }

  bool get isAlive => currentHp > 0;
}
