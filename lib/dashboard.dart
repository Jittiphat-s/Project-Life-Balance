import 'package:flutter/material.dart';
import 'rewards_page.dart';
import 'notification_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _xp = 0;
  int _level = 1;
  String _badge = '';
  List<String> _earnedBadges = [];
  int _selectedIndex = 0;

  List<Map<String, dynamic>> _missions = [];

  int get _xpRequired => 100 + (_level - 1) * 50; // ✅ สูตร XP progression

  void _completeMission(Map<String, dynamic> mission) {
    setState(() {
      _xp += (mission['xpGain'] as int);
      _missions.remove(mission);

      if (_xp >= _xpRequired) {
        _xp -= _xpRequired;
        _level++;
        _updateBadge();
      }
    });

    NotificationService.showNotification(
      title: 'Mission Completed!',
      body: 'You earned ${(mission['xpGain'] as int)} XP 🎉',
    );
  }

  void _updateBadge() {
    if (_level == 3) {
      _badge = 'LifeBalance Beginner';
    } else if (_level == 10) {
      _badge = 'LifeBalance Determined';
    } else if (_level == 20) {
      _badge = 'LifeBalance Platinum';
    } else if (_level == 30) {
      _badge = 'LifeBalance Diamond';
    } else if (_level == 50) {
      _badge = 'LifeBalance Champion';
    } else if (_level == 80) {
      _badge = 'Fitness Master';
    } else if (_level == 100) {
      _badge = 'Fitness Hero';
    } else if (_level == 500) {
      _badge = 'Fitness Master';
    } else if (_level == 1000) {
      _badge = 'LifeBalance Legend';
    }

    if (_badge.isNotEmpty && !_earnedBadges.contains(_badge)) {
      _earnedBadges.add(_badge);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildPage() {
    if (_selectedIndex == 0) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Level $_level',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                if (_badge.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text('Badge: $_badge',
                        style: const TextStyle(
                            fontSize: 16, color: Colors.orange)),
                  ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: _xp / _xpRequired,
                  backgroundColor: Colors.grey[300],
                  color: Colors.blue,
                  minHeight: 10,
                ),
                const SizedBox(height: 8),
                Text('XP: $_xp / $_xpRequired'),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.pushNamed(
                      context,
                      '/missions',
                      arguments: _missions,
                    );
                    if (result != null && result is List<Map<String, dynamic>>) {
                      setState(() {
                        _missions = result;
                      });
                    }
                  },
                  child: const Text("ไปที่หน้ารับภารกิจ"),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _missions.length,
              itemBuilder: (context, index) {
                final mission = _missions[index];
                return Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(mission['icon'], color: mission['color']),
                    title: Text(mission['title']),
                    subtitle: Text(mission['subtitle']),
                    trailing: ElevatedButton(
                      onPressed: () {
                        _completeMission(mission);
                      },
                      child: const Text('Complete'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    } else if (_selectedIndex == 1) {
      return RewardsPage(badges: _earnedBadges);
    } else {
      return const Center(child: Text('Settings Page'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LifeBalance')),
      body: _buildPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Rewards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
