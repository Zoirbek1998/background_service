import 'package:background_service/repository/location_service_repository.dart';
import 'package:background_service/services/background_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:workmanager/workmanager.dart';

import 'home_screen.dart';
import 'notification/notification.dart';

final notificationService =
    NotificationService(FlutterLocalNotificationsPlugin());

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late BackgroundService backgroundService;
  late LocationServiceRepository locationServiceRepository;

  @override
  void initState() {
    super.initState();
    backgroundService = BackgroundService();
    locationServiceRepository = LocationServiceRepository();
  }

  @pragma('vm:entry-point')
  @override
  Future<void> didChangeDependencies() async {
    notificationService.initialize(context);
    await locationServiceRepository.fetchLocationByDeviceGPS();
    if (await backgroundService.instance.isRunning()) {
      await backgroundService.initializeService();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
              onPressed: () async {
                await backgroundService.initializeService();
                // backgroundService.setServiceAsForeGround();
              },
              child: Text("Locall on")),
        ),
      ),
    );
  }
}
