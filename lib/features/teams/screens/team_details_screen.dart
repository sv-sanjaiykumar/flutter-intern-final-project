import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TeamDetailScreen extends StatelessWidget {
  final String teamId;

  const TeamDetailScreen({super.key, required this.teamId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Team Details')),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('teams').doc(teamId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Team not found'));
          }

          final team = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Team: ${team['name']}', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 12),
                Text('Members: ${team['members']}'),
                const SizedBox(height: 12),
                const Text('Habits:'),
                Wrap(
                  spacing: 8,
                  children: List<String>.from(team['habits']).map((habit) {
                    return Chip(label: Text(habit));
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
