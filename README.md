# PokéFlutter TCG

![PokéFlutter Banner](assets/images/banner.png)

**PokéFlutter TCG** est une application mobile cross-platform inspirée du jeu de cartes Pokémon TCG. Ce projet, développé en Flutter et Dart, vous plonge dans un univers où vous pouvez consulter, constituer et affronter des équipes de Pokémon grâce à une interface moderne et dynamique, enrichie par des animations captivantes.

---

## Table des matières

- [Présentation](#présentation)
- [Fonctionnalités](#fonctionnalités)
- [Architecture & Technologies](#architecture--technologies)
- [Installation](#installation)
- [Utilisation](#utilisation)
- [Personnalisation & Améliorations](#personnalisation--améliorations)
- [Contributeurs](#contributeurs)
- [Licence](#licence)

---

## Présentation

PokéFlutter TCG vous permet de :
- Parcourir un **Pokédex** complet grâce à l'intégration de l'API [PokéAPI](https://pokeapi.co/).
- Visualiser les détails de chaque Pokémon (nom, image, statistiques, types, etc.) via une interface **Master/Detail** intuitive.
- Constituer votre équipe de 6 Pokémon en sélectionnant manuellement vos favoris.
- Affronter une Intelligence Artificielle qui génère automatiquement une équipe de 6 Pokémon.
- Vivre des combats en tour par tour avec des animations dynamiques (avec [flutter_animate](https://pub.dev/packages/flutter_animate) et [hyper_effects](https://pub.dev/packages/hyper_effects)) pour un rendu immersif et ludique.

---

## Fonctionnalités

- **Navigation fluide** avec [GoRouter](https://pub.dev/packages/go_router) :
  - Écran **Master** (Liste des Pokémon)
  - Écran **Détail** (Informations détaillées sur chaque Pokémon)
  - Écran **Équipe** (Sélection et visualisation des équipes)
  - Écran **Combat** (Système de combat TCG inspiré des mécaniques Pokémon)

- **Gestion d'état** grâce à [Provider](https://pub.dev/packages/provider) pour :
  - Stocker et persister les équipes d'utilisateur et d'IA.
  - Gérer le cycle de vie du combat (sélection du Pokémon actif, suivi des scores, etc.).

- **Animations et Effets** :
  - Animations fluides sur les écrans et les composants (fade, slide, scale) avec [flutter_animate](https://pub.dev/packages/flutter_animate).
  - Effets visuels accrocheurs sur les actions clés (attaques, transitions, popups).

- **Communication API** :
  - Récupération des données Pokémon via [PokéAPI](https://pokeapi.co/).
  - Gestion des requêtes HTTP avec [Dio](https://pub.dev/packages/dio).

- **Personnalisation UI/UX** :
  - Intégration de Google Fonts pour une typographie sur-mesure.
  - Splash Screen et App Icon customisés grâce à [flutter_native_splash](https://pub.dev/packages/flutter_native_splash) et [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons).

---

## Architecture & Technologies

Le projet est structuré de manière à favoriser la maintenabilité et l’extensibilité :

