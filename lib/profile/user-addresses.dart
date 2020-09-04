import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enc_flutter_2020_f1/constants/app-constants.dart';
import 'package:enc_flutter_2020_f1/model/address.dart';
import 'package:enc_flutter_2020_f1/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

fetchCurrentLocation() async{

  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  LocationData _locationData; // which shall contain the current location for the User

  _serviceEnabled = await location.serviceEnabled();    // Accessing the Activated LocationService on the Platform (Android/iOS)
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();  // Requesting for the LocationService to get Active on the Platform (Android/iOS)
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();  // Request for Permissions to access location on user device
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  _locationData = await location.getLocation();

  return _locationData;
}

saveUserAddressIntoFirebase(Address address){
  FirebaseFirestore db = FirebaseFirestore.instance;
  db.collection(Constants.USERS_COLLECTION).doc(Utils.UID)
      .update({"addresses": FieldValue.arrayUnion([address.toMap()])}).then((value){
     print("Address Saved for User");
  });
}

class AddressesPage extends StatefulWidget {
  @override
  _AddressesPageState createState() => _AddressesPageState();
}

class _AddressesPageState extends State<AddressesPage> {

  LocationData locationData;
  Address address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Addresses"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            locationData != null ? Text("Location Data ${locationData.latitude}, ${locationData.longitude}") : Text("Press FAB to Fetch Location"),
            RaisedButton(
              child: Text("ADD ADDRESS"),
              onPressed: () async {
                // Add the Address into the Firebase
                address = Address.init(adrsLine: "2144 B20 Redwood Shores",
                    city:"Ludhiana", zipCode:141001, label:"Work", location: GeoPoint(locationData.latitude, locationData.longitude));
                saveUserAddressIntoFirebase(address);
              },
            ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.gps_fixed),
        onPressed: () async{
          print("Fetching Location");
          // Fetch Current Location of the User
          locationData = await fetchCurrentLocation();
          setState(() {});
        },
      ),
    );
  }
}

// PS: Create a GUI for Address Data input from User
//     City must be selected from Dropdown :)
