import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tzData.initializeTimeZones();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    const LinuxInitializationSettings linuxSettings =
        LinuxInitializationSettings(defaultActionName: 'Open notification');

    const WindowsInitializationSettings windowsSettings =
        WindowsInitializationSettings(
          appName: 'LifeBalance',
          appUserModelId: 'com.example.project_life_balance',
          guid: '550e8400-e29b-41d4-a716-446655440000', 
        );


    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
      linux: linuxSettings,
      windows: windowsSettings,
    );

    await _notificationsPlugin.initialize(
      settings: settings, // ✅ ต้องใส่ชื่อ parameter "settings"
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // handle notification tap here if needed
      },
    );
  }

  static Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'instant_channel',
      'Instant Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
      linux: LinuxNotificationDetails(),
      windows: WindowsNotificationDetails(),
    );

    await _notificationsPlugin.show(
      id: 0,
      title: title,
      body: body,
      notificationDetails: details,
    );
  }

  static Future<void> scheduleWaterReminders(int intervalHours) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'hydration_channel',
      'Hydration Reminders',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
      linux: LinuxNotificationDetails(),
      windows: WindowsNotificationDetails(),
    );

    for (int i = 1; i <= 6; i++) {
      await _notificationsPlugin.zonedSchedule(
        id: i,
        title: 'Time to drink water 💧',
        body: 'Stay hydrated for better health!',
        scheduledDate:
            tz.TZDateTime.now(tz.local).add(Duration(hours: intervalHours * i)),
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }
}
