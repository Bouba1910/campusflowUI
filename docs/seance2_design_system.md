# Design system v1

## Couleurs

| Rôle | Valeur | Usage |
| --- | --- | --- |
| Primaire | `#3D5A73` | Couleur d'amorçage du thème, boutons principaux, éléments sélectionnés. |
| Surface claire | `#FFFFFF` | Fond des écrans et des cartes. |
| Texte gris foncé | `#37474F` | Titres et textes courants. |
| Texte secondaire | `#607D8B` | Sous-titres, dates, états « terminée ». |
| Trait | `#CFD8DC` | Séparateurs et bordures des champs. |

Le thème Material 3 est généré à partir de la couleur primaire `#3D5A73` dans `lib/app.dart`. Le texte gris foncé sur surface claire assure un contraste supérieur à 4,5:1, conforme au minimum exigé pour le texte courant.

## Typographie

Typographie Material par défaut (famille Roboto selon la plateforme, via `ThemeData` Material 3). Aucune police personnalisée n'est ajoutée : les styles `titleLarge`, `titleMedium`, `bodyMedium` et `labelLarge` de Material suffisent pour la version 1.

## Composants

### Bouton

`FilledButton`, fond primaire, texte blanc, coins arrondis de 8 dp, hauteur minimale 48 dp. Libellés courts à l'infinitif : « Ajouter », « Enregistrer », « Marquer comme faite ». Le bouton désactivé garde le même fond avec une opacité réduite.

### Carte de tâche

`Card` sans ombre, fond surface claire, bordure arrondie de 8 dp, marge interne de 16 dp. Contenu : titre en `titleMedium`, date sur la ligne suivante en `bodyMedium` avec texte secondaire, état « Terminée » barré. Un trait fin sépare les cartes dans la liste.

### Champ de saisie

`TextFormField` avec `InputDecoration` : libellé flottant, bordure inférieure ou contour fine `OutlineInputBorder`, trait `#CFD8DC`, hauteur minimale 48 dp. Message d'erreur sous le champ, en texte secondaire. Le champ de description accepte 3 à 5 lignes.

## Tailles de fenêtre visées

- Smartphone : 360 dp de large, référence des wireframes 360 × 640.
- Tablette : 840 dp de large, seuil de bascule du mode deux panneaux dans `lib/screens/taches_screen.dart` ; wireframe de référence 900 × 640.
- En dessous de 840 dp, une seule colonne avec navigation basse ; au-dessus, liste à gauche et détail à droite.

## Contraste

Le contraste minimal visé pour tout texte est de 4,5:1 sur son fond, conformément aux recommandations WCAG AA. Les combinaisons primaire/blanc et gris foncé/blanc sont vérifiées ; le texte secondaire n'est utilisé que sur surface claire.
