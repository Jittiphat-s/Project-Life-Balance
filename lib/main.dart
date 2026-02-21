import 'package:flutter/material.dart';
import 'notification_service.dart';
import 'dashboard.dart';
import 'missions_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init(); // ✅ เริ่มระบบแจ้งเตือน
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifeBalance',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const DashboardPage(),
      routes: {
        '/missions': (context) => const MissionsPage(),
         },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                NotificationService.showNotification(
                  title: "Hello 👋",
                  body: "This is a test notification",
                );
              },
              child: const Text("Show Notification"),
            ),
            ElevatedButton(
              onPressed: () {
                NotificationService.scheduleWaterReminders(2);
              },
              child: const Text("Schedule Water Reminders"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
