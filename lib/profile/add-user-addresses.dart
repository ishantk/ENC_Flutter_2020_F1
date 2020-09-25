import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enc_flutter_2020_f1/constants/app-constants.dart';
import 'package:enc_flutter_2020_f1/model/address.dart' as a;
import 'package:enc_flutter_2020_f1/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:enc_flutter_2020_f1/model/user.dart' as u;

import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';

class AddressesPage extends StatefulWidget {
  @override
  _AddressesPageState createState() => _AddressesPageState();
}

class _AddressesPageState extends State<AddressesPage> {

  LocationData locationData;

  a.Address address;

  String _text = "initial";
  String _adressline='';
  String _locality = '';
  String _city='';
  String _state = '';
  String _postalcode = '';

  final labelController = TextEditingController();

  fetchCurrentLocation() async {
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
    return _locationData;
  }

  fetchAndUpdateAddressDetails(Coordinates coordinates) async {
    // addresses is a List of Address
    final addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      _adressline = addresses.first.addressLine;
      _locality = addresses.first.locality;
      _city = addresses.first.subAdminArea;
      _state = addresses.first.adminArea;
      _postalcode = addresses.first.postalCode;
    });
  }

  saveUserAddressIntoFirebase(a.Address address) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection(Constants.USERS_COLLECTION).doc(Utils.UID).update({
      "addresses": FieldValue.arrayUnion([address.toMap()])
    }).then((value) {
      print("Address Saved for User");
    });
  }

  @override
  void dispose() {
    super.dispose();
    labelController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2F3C51),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff2F3C51),
      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  height: MediaQuery.of(context).size.height - 82.0,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: "Your",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                          )),
                      TextSpan(
                          text: "\nLocation",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 45,
                              fontWeight: FontWeight.bold))
                    ]),
                  ),
                ),
              ),
              Positioned(
                top: 120,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(75))),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50, 60, 8, 0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 110,
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              color: Colors.transparent,
                              elevation: 0,
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text: "Full Address:\n",
                                      style: TextStyle(
                                        color: Color(0xff2F3C51),
                                        fontSize: 17,
                                      )),
                                  _adressline != null
                                      ? TextSpan(
                                      text: "$_adressline",
                                      style: TextStyle(
                                          color: Color(0xff2F3C51),
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold))
                                      : TextSpan(
                                      text:
                                      "Tap icon to access your location",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic)),
                                ]),
                              ),
                            ),
                          ),
                          Divider(
                            color: Color(0xff2F3C51),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              color: Colors.transparent,
                              elevation: 0,
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text: "City:\n",
                                      style: TextStyle(
                                        color: Color(0xff2F3C51),
                                        fontSize: 17,
                                      )),
                                  _city != null
                                      ? TextSpan(
                                      text: "$_city",
                                      style: TextStyle(
                                          color: Color(0xff2F3C51),
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold))
                                      : TextSpan(
                                      text:
                                      "Tap icon to access your location",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic)),
                                ]),
                              ),
                            ),
                          ),
                          Divider(
                            color: Color(0xff2F3C51),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: ListTile(
                              title: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text: "Label:\n",
                                      style: TextStyle(
                                        color: Color(0xff2F3C51),
                                        fontSize: 18,
                                      )),
                                  TextSpan(
                                      text: "Tap to edit\n",
                                      style: TextStyle(
                                          color: (Colors.grey),
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic))
                                ]),
                              ),
                              subtitle: Text(
                                labelController.text,
                                style: TextStyle(
                                    color: Color(0xff2F3C51),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(Icons.edit),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  child: new Dialog(
                                    child: new Container(
                                      height: 100,
                                      width: 400,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: TextField(
                                            decoration: InputDecoration(
                                                suffixIcon: InkWell(
                                                  child:
                                                  new Icon(Icons.touch_app),
                                                  onTap: () {
                                                    setState(() {
                                                      this._text =
                                                          labelController.text;
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                hintText: "type"),
                                            controller: labelController,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Divider(
                            color: Color(0xff2F3C51),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RaisedButton(
                            color: Color(0xff2F3C51),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(  color: Color(0xff2F3C51),)
                            ),
                            child: Text("Save Address",style: TextStyle(color: Colors.white),),
                            onPressed: () async {
                              // Add the Address into the Firebase
                              address = a.Address.init(
                                  adrsLine: _adressline,
                                  city: _city,
                                  state: _state,
                                  zipCode: _postalcode,
                                  label: labelController.text,
                                  location: GeoPoint(locationData.latitude,
                                      locationData.longitude));

                              fetchAndUpdateAddressDetails(Coordinates(locationData.latitude,
                                  locationData.longitude));
                              saveUserAddressIntoFirebase(address);
                              return ("Address saved");
                            },
                          ),
                        ],
                      ),
                    )),
              )
            ],
          )),
      floatingActionButton: FloatingActionButton(backgroundColor:  Color(0xff2F3C51) ,
        child: Icon(
          Icons.gps_fixed,
          color: Colors.white,
        ),
        onPressed: () async {
          print("Fetching Location");
          // Fetch Current Location of the User
          locationData = await fetchCurrentLocation();
          fetchAndUpdateAddressDetails(
              Coordinates(locationData.latitude, locationData.longitude));
          setState(() {});
        },
      ),
    );
  }
}


/*
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
*/