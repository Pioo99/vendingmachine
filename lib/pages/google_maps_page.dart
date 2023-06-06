import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/locationdata.dart';

class MapScreen extends StatefulWidget {

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  LocationData? _locationData;

  @override
  void initState() {
    super.initState();
    _getLocationData();
  }

  void _getLocationData() {
    DatabaseReference locationRef = FirebaseDatabase.instance
        .ref()
        .child('coordenada');

    locationRef.once().then((DatabaseEvent event) {
      final snapshot = event.snapshot;
      Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
      double latitude = data['latitude'];
      double longitude = data['longitude'];

      setState(() {
        _locationData = LocationData(latitude, longitude);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Map'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _locationData!.latitude.toString(),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              _locationData!.longitude.toString(),
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
