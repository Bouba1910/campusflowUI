# Fiche comparative Android / iOS

| Critère | Android | iOS | Contexte Afrique francophone |
| --- | --- | --- | --- |
| Philosophie | Système ouvert, personnalisation poussée, multi-constructeurs. | Système fermé, expérience uniforme, contrôle strict par Apple. | Les deux modèles coexistent ; la simplicité d'usage prime sur la personnalisation. |
| Architecture | Noyau Linux, couche Java/Kotlin, activités et services. | Noyau Darwin, couche Objective-C/Swift, UIKit et SwiftUI. | Peu d'impact direct ; la différence se voit surtout dans la maintenance. |
| Langage | Kotlin aujourd'hui, Java pour les applications anciennes. | Swift aujourd'hui, Objective-C pour les applications anciennes. | Peu de développement natif local ; le choix du langage pèse sur le recrutement. |
| Cycle de vie | Activités avec états `onCreate`, `onStart`, `onResume`, `onPause`. | Contrôleurs avec `viewDidLoad`, `viewWillAppear`, `viewDidDisappear`. | La sauvegarde de l'état est utile quand la connexion coupe pendant la saisie. |
| Permissions | Déclaration dans le manifeste, demande à l'installation ou à l'exécution selon la version. | Déclaration dans `Info.plist`, demande à l'usage, avec motif obligatoire. | Demander le moins de permissions possible pour garder la confiance des étudiants. |
| Stockage | Stockage interne, externe, préférences partagées, SQLite via Room. | Documents de l'application, `UserDefaults`, Core Data, SQLite. | Prévoir un fonctionnement hors ligne : les données doivent rester sur l'appareil. |
| Distribution | Google Play, magasins tiers, installation directe de l'APK. | App Store uniquement, contrôle de publication strict. | Le Play Store domine ; l'installation directe reste utile là où le store est peu accessible. |
| Fragmentation | Très forte : plusieurs marques, tailles d'écran et versions d'Android. | Faible : peu de modèles et mises à jour rapides. | Les appareils bas de gamme et les anciennes versions sont fréquents. |
| Mises à jour | Dépendent du constructeur et de l'opérateur. | Dépendent d'Apple, déployées rapidement. | Ne pas supposer la dernière version du système chez les utilisateurs. |
| Contraintes de développement | Plusieurs versions et densités d'écran à tester. | Un seul environnement à tester, mais compte développeur et machine Apple requis. | Une équipe étudiante a intérêt à limiter le nombre de cibles de test. |
| Coût appareil | Large gamme, entrée de gamme abordable. | Appareils généralement plus chers, peu de marché d'occasion structuré. | Le parc étudiant est majoritairement Android ; le coût d'accès reste un critère. |
| Réseau / connectivité | Support large des réseaux, gestion des SIM duales fréquente. | Support des réseaux plus homogène, double SIM selon les modèles. | Coupures réseau et coût des données mobiles : prévoir le mode hors ligne et la synchronisation différée. |
| Outillage | Android Studio, émulateur, Gradle. | Xcode, simulateur, Swift Package Manager. | Un seul outillage multiplateforme réduit la charge de configuration. |
| Communauté | Très large, nombreuses ressources et bibliothèques. | Large, mais plus fermée et dépendante des choix d'Apple. | Une communauté active aide à résoudre les problèmes avec peu de moyens. |
