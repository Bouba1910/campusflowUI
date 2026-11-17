import 'package:flutter/material.dart';

class CoursScreen extends StatelessWidget {
  const CoursScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'Les cours de CampusFlow seront affichés ici.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
