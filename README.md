Nom : COMPAORE Aboubacar Sidiki
Filiere / Niveau : MSI / M1
# CampusFlow – application Flutter

Application Flutter pour consulter, ajouter et suivre des échéances. La liste et le détail communiquent avec le formulaire, et l'interface s'adapte aux tablettes à partir de 840 dp de largeur.

## Prérequis

- Flutter 3.44 ou plus récent

## Commandes

```bash
flutter pub get       # installer les dépendances
flutter run           # lancer l'application
flutter test          # lancer les tests
flutter analyze       # vérifier le code
```

## Structure

- `lib/main.dart` : point d'entrée et thème de l'application
- `lib/models/task.dart` : modèle `Task`
- `lib/data/sample_tasks.dart` : échéances de départ
- `lib/screens/home_screen.dart` : liste, navigation et disposition tablette
- `lib/screens/task_detail_screen.dart` : détail d'une échéance
- `lib/screens/task_form_screen.dart` : formulaire de création
- `lib/utils/date_format.dart` : formatage des dates en français
- `test/widget_test.dart` : tests de l'interface
