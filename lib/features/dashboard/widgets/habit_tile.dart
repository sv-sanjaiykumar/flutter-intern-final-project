import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {
  final String title;
  final String time;
  final bool isCompleted;
  final ValueChanged<bool?> onCheckChanged;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const HabitTile({
    super.key,
    required this.title,
    required this.time,
    required this.isCompleted,
    required this.onCheckChanged,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      child: ListTile(
        leading: Checkbox(
          value: isCompleted,
          onChanged: onCheckChanged,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                decoration:
                    isCompleted ? TextDecoration.lineThrough : null,
              ),
        ),
        subtitle: Text(
          time,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withOpacity(0.7),
              ),
        ),
        trailing: PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) {
            if (value == 'Edit') {
              onEdit();
            } else if (value == 'Delete') {
              onDelete();
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem<String>(
              value: 'Edit',
              child: Text('Edit'),
            ),
            PopupMenuItem<String>(
              value: 'Delete',
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
