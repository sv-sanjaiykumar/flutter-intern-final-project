import 'package:flutter/material.dart';

class TeamCard extends StatelessWidget {
  final String name;
  final int members;
  final List<String> habits;

  const TeamCard({
    super.key,
    required this.name,
    required this.members,
    required this.habits,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Chip(
                  label: Text('$members members'),
                  backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: habits.map((habit) => Chip(
                label: Text(habit),
                backgroundColor: Theme.of(context).colorScheme.surface,
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}