import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class GoogleMapsPage extends StatefulWidget {
  @override
  _GoogleMapsPageState createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition initialCameraPosition = CameraPosition(
    // Initial Delhi LatLong
    target: LatLng(28.6472799,76.8130694),
    zoom: 12.0,
  );

  CameraPosition currentCameraPosition;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        zoomGesturesEnabled: true,
        zoomControlsEnabled: true,
        trafficEnabled: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: fetchCurrentLocation,
        label: Text('My Location'),
        icon: Icon(Icons.gps_fixed),
      ),
    );
  }

  Future<void> fetchCurrentLocation() async {

    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData
    _locationData; // which shall contain the current location for the User

    _serviceEnabled = await location
        .serviceEnabled(); // Accessing the Activated LocationService on the Platform (Android/iOS)
    if (!_serviceEnabled) {
      _serviceEnabled = await location
          .requestService(); // Requesting for the LocationService to get Active on the Platform (Android/iOS)
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location
          .requestPermission(); // Request for Permissions to access location on user device
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    currentCameraPosition = CameraPosition(
    // Current LatLong
    target: LatLng(_locationData.latitude, _locationData.longitude),
    zoom: 12.0,
    );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(currentCameraPosition));
  }

}

// Assignment:
// 1. Create Markers on Google Maps
// 2. In the AppBar Create a PopUpMenu where we can switch different types of maps