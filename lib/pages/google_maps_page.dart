import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();
  double latitude = 0.0;
  double longitude = 0.0;

  @override
  void initState() {
    super.initState();
    fetchLocationFromFirebase();
  }

  void fetchLocationFromFirebase() {
    _databaseReference.child('location').once().then((DatabaseEvent event) {
      var snapshot = event.snapshot;
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        latitude = values['latitude'] ?? 0.0;
        longitude = values['longitude'] ?? 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(latitude, longitude),
                zoom: 15,
              ),
              markers: Set<Marker>.from([
                Marker(
                  markerId: MarkerId('location'),
                  position: LatLng(latitude, longitude),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
