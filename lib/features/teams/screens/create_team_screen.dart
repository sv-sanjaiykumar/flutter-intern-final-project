import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateTeamScreen extends StatefulWidget {
  const CreateTeamScreen({super.key});

  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  final _teamNameController = TextEditingController();
  final _memberCountController = TextEditingController();
  final _customHabitController = TextEditingController();

  final List<String> _selectedHabits = [];
  final List<String> _availableHabits = [
    'Morning Workout',
    'Reading',
    'Meditation',
    'Healthy Eating',
    'Study Session',
    'Exercise',
  ];

  @override
  void dispose() {
    _teamNameController.dispose();
    _memberCountController.dispose();
    _customHabitController.dispose();
    super.dispose();
  }

  Future<void> createTeamInFirebase() async {
    try {
      final teamData = {
        'name': _teamNameController.text,
        'members': int.parse(_memberCountController.text),
        'habits': _selectedHabits,
        'createdAt': Timestamp.now(),
      };

      await FirebaseFirestore.instance.collection('teams').add(teamData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Team created successfully!')),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create team: $e')),
      );
    }
  }

  void addCustomHabit() {
    final newHabit = _customHabitController.text.trim();
    if (newHabit.isNotEmpty && !_selectedHabits.contains(newHabit)) {
      setState(() {
        _selectedHabits.add(newHabit);
        _customHabitController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Team'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Team Details', style: theme.textTheme.headlineSmall),
            const SizedBox(height: 24),
            TextField(
              controller: _teamNameController,
              decoration: InputDecoration(
                labelText: 'Team Name',
                hintText: 'Enter team name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: theme.colorScheme.surface,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _memberCountController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  int? count = int.tryParse(value);
                  if (count != null && count > 15) {
                    _memberCountController.text = '15';
                    _memberCountController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _memberCountController.text.length),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Maximum team size is 15 members'),
                      ),
                    );
                  }
                }
              },
              decoration: InputDecoration(
                labelText: 'Team Size',
                hintText: 'Enter number of team members (max 15)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: theme.colorScheme.surface,
              ),
            ),
            const SizedBox(height: 24),
            Text('Team Habits', style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),

            /// Chip Selection
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _availableHabits.map((habit) {
                final isSelected = _selectedHabits.contains(habit);
                return FilterChip(
                  label: Text(habit),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedHabits.add(habit);
                      } else {
                        _selectedHabits.remove(habit);
                      }
                    });
                  },
                  backgroundColor: theme.colorScheme.surface,
                  selectedColor: theme.colorScheme.primary.withOpacity(0.2),
                  checkmarkColor: theme.colorScheme.primary,
                );
              }).toList(),
            ),

            const SizedBox(height: 24),
            Text('Add Custom Habit', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),

            /// Custom Habit TextField + Button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _customHabitController,
                    decoration: InputDecoration(
                      hintText: 'Enter your own habit',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: theme.colorScheme.surfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: addCustomHabit,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Add'),
                )
              ],
            ),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_teamNameController.text.isNotEmpty &&
                      _selectedHabits.isNotEmpty &&
                      _memberCountController.text.isNotEmpty) {
                    createTeamInFirebase();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill in all required fields')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Create Team'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
