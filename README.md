Nom : COMPAORE Aboubacar Sidiki
Filiere / Niveau : MSI / M1
# CampusFlow – TP Programmation Mobile

Projet unique des séances 1 à 7 : décision de plateforme, conception, modèles Dart, application Flutter, navigation et état partagé, puis API locale avec authentification.

## Prérequis

- Flutter 3.44 ou plus récent
- Node.js et json-server pour l'API locale (`npm install -g json-server`)

## Commandes

```bash
flutter pub get
flutter run
flutter test
cd packages/campusflow_models && dart test
json-server --watch api/db.json --port 3000
```

Sur l'émulateur Android, l'API locale est appelée via `10.0.2.2:3000`.

## Structure

- `docs/` : livrables des séances 1 et 2 (fiche, autopsie, persona, parcours, wireframes, design system)
- `packages/campusflow_models/` : modèles Dart et tests de la séance 3
- `api/db.json` : données de json-server
- `lib/core/` : routeur, client Dio et stockage sécurisé du jeton
- `lib/data/` : contrat `TaskRepository`, implémentation API et implémentation fictive
- `lib/state/` : Riverpod, filtres et authentification
- `lib/screens/` : écrans Connexion, Tâches, Détail, Formulaire, Cours et Profil
- `lib/widgets/` : coque de navigation et détail d'une tâche
- `test/` : tests de l'interface
