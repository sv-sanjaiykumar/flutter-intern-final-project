import 'package:flutter/material.dart';
import 'habit_tile.dart';

class HabitList extends StatelessWidget {
  const HabitList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 1, 
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        return HabitTile(
          title: 'Morning Meditation',
          time: '7:00 AM',
          isCompleted: false,
          onCheckChanged: (value) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Checkbox changed at index $index')),
            );
          },
          onEdit: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Edit clicked at index $index')),
            );
          },
          onDelete: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Delete clicked at index $index')),
            );
          },
        );
      },
    );
  }
}
