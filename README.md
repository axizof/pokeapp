# PokéFlutter TCG


**PokéFlutter TCG** est une application mobile cross-platform inspirée du jeu de cartes Pokémon TCG. Ce projet, développé en Flutter et Dart

---

## Table des matières

- [Présentation](#présentation)
- [Fonctionnalités](#fonctionnalités)
- [Architecture & Technologies](#architecture--technologies)
- [Installation](#installation)
- [Utilisation](#utilisation)

---

## Présentation

PokéFlutter TCG vous permet de :
- Parcourir un **Pokédex** complet grâce à l'intégration de l'API [PokéAPI](https://pokeapi.co/).
- Visualiser les détails de chaque Pokémon (nom, image, statistiques, types, etc.) via une interface **Master/Detail** intuitive.
- Constituer votre équipe de 6 Pokémon en sélectionnant manuellement vos favoris.
- Affronter une Intelligence Artificielle qui génère automatiquement une équipe de 6 Pokémon.
- Vivre des combats en tour par tour avec des animations dynamiques (avec [flutter_animate](https://pub.dev/packages/flutter_animate))

---

## Fonctionnalités

- **Navigation fluide** avec [GoRouter](https://pub.dev/packages/go_router) :
  - Écran **Master** (Liste des Pokémon)
  - Écran **Détail** (Informations détaillées sur chaque Pokémon)
  - Écran **Équipe** (Sélection et visualisation des équipes)
  - Écran **Combat** (Système de combat TCG inspiré des mécaniques Pokémon)

- **Gestion d'état** pour :
  - Stocker et persister les équipes d'utilisateur et d'IA.
  - Gérer le cycle de vie du combat (sélection du Pokémon actif, suivi des scores, etc.).

- **Animations et Effets** :
  - Animations fluides sur les écrans et les composants (fade, slide, scale) avec [flutter_animate](https://pub.dev/packages/flutter_animate).
  - Effets visuels accrocheurs sur les actions clés (attaques, transitions, popups).

- **Communication API** :
  - Récupération des données Pokémon via [PokéAPI](https://pokeapi.co/).
  - Gestion des requêtes HTTP avec [Dio](https://pub.dev/packages/dio).

- **Personnalisation UI/UX** :

---

## Architecture & Technologies

Le projet est structuré de manière à favoriser la maintenabilité et l’extensibilité.

### Technologies utilisées :
- **Flutter & Dart** : Développement cross-platform (Android, iOS, Web)
- **Dio** : Gestion des appels HTTP
- **GoRouter** : Navigation et routing
- **Flutter Animate** : Effets et animations visuels

  ---

## Installation

### Prérequis

- [Flutter SDK](https://flutter.dev/docs/get-started/install)

  ### Installer les dépendances
  - flutter pub get
 
  - Lancer l'application en mode debug :
      flutter run

  - build web:
      flutter build web
  




