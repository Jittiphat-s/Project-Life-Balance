import 'package:flutter/material.dart';

class MissionsPage extends StatefulWidget {
  const MissionsPage({super.key});

  @override
  State<MissionsPage> createState() => _MissionsPageState();
}

class _MissionsPageState extends State<MissionsPage> {
  final List<Map<String, dynamic>> availableMissions = [
    {'icon': Icons.local_drink, 'color': Colors.blue, 'title': 'Drink Water (1 glass)', 'subtitle': 'Hydration mission', 'xpGain': 5, 'type': 'water'},
    {'icon': Icons.directions_run, 'color': Colors.green, 'title': 'Run 100m', 'subtitle': 'Short run mission', 'xpGain': 10, 'type': 'run'},
    {'icon': Icons.directions_run, 'color': Colors.orange, 'title': 'Run 500m', 'subtitle': 'Medium run mission', 'xpGain': 20, 'type': 'run'},
    {'icon': Icons.directions_run, 'color': Colors.red, 'title': 'Run 1km', 'subtitle': 'Long run mission', 'xpGain': 50, 'type': 'run'},
    {'icon': Icons.bedtime, 'color': Colors.purple, 'title': 'Sleep 15 minutes', 'subtitle': 'Short nap mission', 'xpGain': 5, 'type': 'sleep'},
    {'icon': Icons.bedtime, 'color': Colors.purple, 'title': 'Sleep 30 minutes', 'subtitle': 'Nap mission', 'xpGain': 15, 'type': 'sleep'},
    {'icon': Icons.bedtime, 'color': Colors.purple, 'title': 'Sleep 1 hour', 'subtitle': 'Rest mission', 'xpGain': 30, 'type': 'sleep'},
    {'icon': Icons.bedtime, 'color': Colors.purple, 'title': 'Sleep 5 hours', 'subtitle': 'Deep sleep mission', 'xpGain': 100, 'type': 'sleep'},
  ];

  List<Map<String, dynamic>> activeMissions = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is List<Map<String, dynamic>>) {
      setState(() {
        activeMissions = args;
      });
    }
  }

  void startMission(Map<String, dynamic> mission) {
    setState(() {
      activeMissions.add(Map<String, dynamic>.from(mission));
    });
    Navigator.pop(context, activeMissions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("รับภารกิจ")),
      body: Column(
        children: [
          // Available Missions
          Expanded(
            child: Column(
              children: [
                const Text("Available Missions",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Expanded(
                  child: ListView.builder(
                    itemCount: availableMissions.length,
                    itemBuilder: (context, index) {
                      final mission = availableMissions[index];
                      return Card(
                        elevation: 4,
                        child: ListTile(
                          leading: Icon(mission['icon'], color: mission['color']),
                          title: Text("${mission['title']} (+${mission['xpGain']} XP)"), // ✅ แสดง XP ด้านหลังชื่อ
                          subtitle: Text(mission['subtitle']),
                          trailing: ElevatedButton(
                            onPressed: () => startMission(mission),
                            child: const Text("Start"),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          const Divider(),

          // Active Missions
          Expanded(
            child: Column(
              children: [
                const Text("Active Missions",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Expanded(
                  child: ListView.builder(
                    itemCount: activeMissions.length,
                    itemBuilder: (context, index) {
                      final mission = activeMissions[index];
                      return Card(
                        elevation: 4,
                        child: ListTile(
                          leading: Icon(mission['icon'], color: mission['color']),
                          title: Text("${mission['title']} (+${mission['xpGain']} XP)"), // ✅ แสดง XP ด้านหลังชื่อ
                          subtitle: Text(mission['subtitle']),
                          trailing: const Icon(Icons.check_circle, color: Colors.green),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
