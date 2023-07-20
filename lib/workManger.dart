import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class WorkManager extends StatefulWidget {
  const WorkManager({Key? key}) : super(key: key);

  @override
  State<WorkManager> createState() => _WorkManagerState();
}

class _WorkManagerState extends State<WorkManager> {

  final Position position;

  void _getUserPosition() async {
    GeolocationStatus geolocationStatus  = await Geolocator().checkGeolocationPermissionStatus();
    Position userLocation = await geoLocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      position = userLocation;
    });
  }

  @override
  void initState() {
    super.initState();
    this._getUserPosition();
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
