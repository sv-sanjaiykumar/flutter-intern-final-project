import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, String>> history = [
    {'title': 'Morning Meditation', 'time': '7:00 AM', 'date': '2025-07-14'},
    {'title': 'Jogging', 'time': '6:30 AM', 'date': '2025-07-13'},
    {'title': 'Reading Book', 'time': '9:00 PM', 'date': '2025-07-13'},
    {'title': 'Yoga', 'time': '8:00 AM', 'date': '2025-07-12'},
  ];

  void deleteHistoryItem(int index, String groupKey) {
    setState(() {
      groupedHistory[groupKey]!.removeAt(index);
      if (groupedHistory[groupKey]!.isEmpty) {
        groupedHistory.remove(groupKey);
      }
    });
  }

  late Map<String, List<Map<String, String>>> groupedHistory;

  @override
  void initState() {
    super.initState();
    groupedHistory = _groupHistoryByDay();
  }

  Map<String, List<Map<String, String>>> _groupHistoryByDay() {
    Map<String, List<Map<String, String>>> map = {};

    for (var entry in history) {
      final date = DateTime.parse(entry['date']!);
      final formattedKey = '${DateFormat.EEEE().format(date)} • ${DateFormat.yMMMMd().format(date)}';

      if (!map.containsKey(formattedKey)) {
        map[formattedKey] = [];
      }
      map[formattedKey]!.add(entry);
    }

    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('History'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: groupedHistory.isEmpty
            ? Center(
                child: Text(
                  'No habit history available.',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              )
            : ListView(
                children: groupedHistory.entries.map((entry) {
                  final groupKey = entry.key;
                  final items = entry.value;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        groupKey,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: items.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          final habit = items[index];
                          return ListTile(
                            leading: const Icon(Icons.check_circle, color: Colors.green),
                            title: Text(
                              habit['title']!,
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text(
                              habit['time']!,
                              style: GoogleFonts.poppins(
                                  fontSize: 14, color: Colors.grey),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => deleteHistoryItem(index, groupKey),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                    ],
                  );
                }).toList(),
              ),
      ),
    );
  }
}
