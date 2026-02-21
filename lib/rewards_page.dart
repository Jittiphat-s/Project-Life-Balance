import 'package:flutter/material.dart';

class RewardsPage extends StatelessWidget {
  final List<String> badges; // รับ Badge ที่สะสมมา

  const RewardsPage({super.key, required this.badges});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Rewards'),
      ),
      body: badges.isEmpty
          ? const Center(
              child: Text(
                'No badges earned yet!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // แสดง 2 คอลัมน์
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: badges.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  child: Center(
                    child: Text(
                      badges[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
