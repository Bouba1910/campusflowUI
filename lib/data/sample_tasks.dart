import '../models/task.dart';

final List<Task> sampleTasks = [
  Task(
    id: 1,
    title: 'Rendre le TP Flutter',
    description: 'Finaliser les écrans et vérifier la navigation.',
    dueDate: DateTime(2026, 11, 6),
  ),
  Task(
    id: 2,
    title: 'Réviser les widgets',
    description: 'Revoir les widgets de mise en page pour le contrôle.',
    dueDate: DateTime(2026, 11, 10),
  ),
  Task(
    id: 3,
    title: 'Préparer la démonstration',
    description: 'Préparer les étapes de démonstration sur tablette.',
    dueDate: DateTime(2026, 11, 14),
  ),
  Task(
    id: 4,
    title: 'Rendre le compte rendu',
    description: 'Le compte rendu du projet a été déposé.',
    dueDate: DateTime(2026, 10, 30),
    isCompleted: true,
  ),
];
