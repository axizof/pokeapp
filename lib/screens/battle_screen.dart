import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:flutter_animate/flutter_animate.dart';

import '../providers/team_provider.dart';
import '../models/pokemon.dart';

class BattlePokemon {
  final Pokemon baseData;
  int currentHp;
  final int minAttack;
  final int maxAttack;

  BattlePokemon({
    required this.baseData,
    required this.currentHp,
    this.minAttack = 5,
    this.maxAttack = 20,
  });

  // Retourne un montant de dégâts aléatoire
  int attackDamage() {
    return Random().nextInt(maxAttack - minAttack + 1) + minAttack;
  }

  bool get isAlive => currentHp > 0;
}

class BattleScreen extends StatefulWidget {
  const BattleScreen({Key? key}) : super(key: key);

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  List<BattlePokemon> _userTeamBattle = [];
  List<BattlePokemon> _aiTeamBattle = [];

  // Pokémons actifs
  BattlePokemon? _userActive;
  BattlePokemon? _aiActive;

  // Scores = nombre de KOs infligés
  int _userScore = 0;
  int _aiScore = 0;

  bool _isUserTurn = true;
  String _coinTossResult = '';

  bool _hasAttackedThisTurn = false;

  String _damageMessage = '';
  bool _showDamageMessage = false;
  Timer? _damageTimer;

  @override
  void initState() {
    super.initState();
    _initBattle();

    // Si l’IA commence
    if (!_isUserTurn) {
      Future.delayed(const Duration(seconds: 1), _aiTurn);
    }
  }

  void _initBattle() {
    final teamProvider = context.read<TeamProvider>();

    // Convertir l'équipe user en liste de BattlePokemon
    _userTeamBattle =
        teamProvider.userTeam.map((p) {
          final hp = p.hp > 0 ? p.hp : 50;
          return BattlePokemon(baseData: p, currentHp: hp);
        }).toList();

    // Convertir l'équipe IA
    _aiTeamBattle =
        teamProvider.aiTeam.map((p) {
          final hp = p.hp > 0 ? p.hp : 50;
          return BattlePokemon(baseData: p, currentHp: hp);
        }).toList();

    // Pile ou Face
    final random = Random();
    final isHeads = random.nextBool();
    _coinTossResult = isHeads ? 'Pile' : 'Face';
    _isUserTurn = isHeads;

    // Sélectionne le Pokémon actif
    _userActive = _chooseNextAlive(_userTeamBattle);
    _aiActive = _chooseNextAlive(_aiTeamBattle);
  }

  BattlePokemon? _chooseNextAlive(List<BattlePokemon> team) {
    for (var bp in team) {
      if (bp.isAlive) return bp;
    }
    return null;
  }

  void _attack({required bool attackerIsUser}) {
    if (_userActive == null || _aiActive == null) {
      return;
    }

    final attacker = attackerIsUser ? _userActive! : _aiActive!;
    final defender = attackerIsUser ? _aiActive! : _userActive!;

    final dmg = attacker.attackDamage();

    setState(() {
      defender.currentHp = (defender.currentHp - dmg).clamp(0, 9999);

      _showDamageAnimation(
        message:
            attackerIsUser
                ? 'Tu infliges $dmg dégâts!'
                : 'IA inflige $dmg dégâts!',
      );

      // Vérifier KO
      if (!defender.isAlive) {
        if (attackerIsUser) {
          _userScore++;
          if (_userScore == 3) {
            _showWinnerDialog('Tu');
            return;
          } else {
            _aiActive = _chooseNextAlive(_aiTeamBattle);
            if (_aiActive == null) {
              _showWinnerDialog('Tu');
              return;
            }
          }
        } else {
          _aiScore++;
          if (_aiScore == 3) {
            _showWinnerDialog('IA');
            return;
          } else {
            _userActive = _chooseNextAlive(_userTeamBattle);
            if (_userActive == null) {
              _showWinnerDialog('IA');
              return;
            }
          }
        }
      }
    });
  }

  void _showDamageAnimation({required String message}) {
    setState(() {
      _damageMessage = message;
      _showDamageMessage = true;
    });

    _damageTimer?.cancel();
    _damageTimer = Timer(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _showDamageMessage = false;
        });
      }
    });
  }

  void _endTurn() {
    setState(() {
      _hasAttackedThisTurn = false;
      _isUserTurn = !_isUserTurn;
    });

    if (!_isUserTurn) {
      Future.delayed(const Duration(seconds: 1), _aiTurn);
    }
  }

  void _aiTurn() {
    if (!_isUserTurn && _aiActive != null && _userActive != null) {
      // L’IA attaque
      _attack(attackerIsUser: false);

      if (mounted) {
        setState(() {
          _isUserTurn = true;
          _hasAttackedThisTurn = false;
        });
      }
    }
  }

  void _showWinnerDialog(String winner) {
    _damageTimer?.cancel();

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          title: const Text(
            'Fin de partie',
          ).animate().slideY(begin: -0.2, duration: 300.ms),
          content: Text(
            '$winner as gagné la partie !',
          ).animate().fade(duration: 300.ms),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ).animate().fade(duration: 300.ms);
      },
    );
  }

  @override
  void dispose() {
    _damageTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Combat Pokémon')
            .animate()
            .fade(duration: 600.ms)
            .slideY(begin: -0.3, end: 0, duration: 600.ms),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: _buildContent()
                .animate()
                .fade(duration: 400.ms)
                .slideX(begin: 0.2, duration: 400.ms),
          ),
          _buildDamageOverlay(),
        ],
      ),
    );
  }

  Widget _buildDamageOverlay() {
    if (!_showDamageMessage) {
      return const SizedBox.shrink();
    }

    return Center(
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          _damageMessage,
          style: const TextStyle(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ).animate().fade(duration: 300.ms).scale(duration: 300.ms),
    );
  }

  Widget _buildContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Pile ou Face
        Text(
          'Pile ou Face : $_coinTossResult',
        ).animate().fade(duration: 500.ms),
        const SizedBox(height: 10),

        Text(
          'Score joueur : $_userScore - Score IA : $_aiScore',
          style: const TextStyle(fontSize: 18),
        ).animate().fade(duration: 500.ms).slideX(begin: -0.2, end: 0),

        const SizedBox(height: 16),

        // Pokémons actifs
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (_userActive != null) ...[
              Column(
                children: [
                  Text('Ton Pokémon Actif: ${_userActive!.baseData.name}'),
                  Text('PV : ${_userActive!.currentHp}'),
                ],
              ).animate().fade(duration: 400.ms).slideX(begin: -0.1, end: 0),
            ] else
              const Text("Aucun Pokémon actif"),
            if (_aiActive != null) ...[
              Column(
                children: [
                  Text('Pokémon IA: ${_aiActive!.baseData.name}'),
                  Text('PV : ${_aiActive!.currentHp}'),
                ],
              ).animate().fade(duration: 400.ms).slideX(begin: 0.1, end: 0),
            ] else
              const Text("Aucun Pokémon actif"),
          ],
        ),
        const SizedBox(height: 24),

        Text(
          _isUserTurn ? 'C’est TON tour' : 'Tour de l’IA',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ).animate().fade(duration: 400.ms).slideY(begin: 0.2, end: 0),

        const SizedBox(height: 24),

        // Boutons si c’est le tour du joueur
        if (_isUserTurn && _userActive != null && _aiActive != null) ...[
          ElevatedButton(
            onPressed:
                _hasAttackedThisTurn
                    ? null
                    : () {
                      _attack(attackerIsUser: true);
                      setState(() {
                        _hasAttackedThisTurn = true;
                      });
                    },
            child: const Text('Attaquer'),
          ).animate().scale(duration: 400.ms).fade(duration: 200.ms),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _endTurn,
            child: const Text('Fin de mon tour'),
          ).animate().scale(duration: 400.ms).fade(duration: 200.ms),
        ],
      ],
    );
  }
}
