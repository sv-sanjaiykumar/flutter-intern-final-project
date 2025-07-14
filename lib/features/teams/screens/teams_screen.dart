import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habit_app/features/teams/screens/team_chat_screen.dart';
import 'package:habit_app/features/teams/screens/create_team_screen.dart';
import 'team_card.dart';

class TeamsScreen extends StatelessWidget {
  const TeamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Teams'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Teams',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),

            /// Fetch real-time data from Firestore
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('teams')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No teams found.'));
                  }

                  final teams = snapshot.data!.docs;

                  return ListView.separated(
                    itemCount: teams.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final teamData = teams[index].data() as Map<String, dynamic>;
                      final teamId = teams[index].id;

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TeamChatScreen(
                                teamId: teamId,
                                teamName: teamData['name'],
                                senderName: user?.displayName ?? user?.email ?? 'Anonymous',
                              ),
                            ),
                          );
                        },
                        child: TeamCard(
                          name: teamData['name'],
                          members: teamData['members'],
                          habits: List<String>.from(teamData['habits']),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateTeamScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
