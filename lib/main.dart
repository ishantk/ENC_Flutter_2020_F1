//import 'package:camera/camera.dart';
//import 'package:enc_flutter_2020_f1/tutorials/application.dart';
//import 'package:enc_flutter_2020_f1/tutorials/capture-image.dart';
//import 'package:flutter/cupertino.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:enc_flutter_2020_f1/auth/food-delivery-app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // This is new implementation from Firebase
  runApp(FoodDeliveryApp());
}

/*void main() {
  FoodDeliveryApp app = FoodDeliveryApp();
  runApp(app);
}*/

//void main() => runApp(FoodDeliveryApp());

/*
Future<void> main() async{

  // till time services within plugins are not initialized dont move further
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain list of cameras -> 0 first camera -> 1 second camera
  final cameras = await availableCameras();

  //final camera = cameras[0];
  //final camera = cameras.first; // Back Camera
  final camera = cameras[1];      // Selfie Camera

  MaterialApp app = MaterialApp(
    theme: ThemeData.dark(),
    routes: {
      "/": (context) => CaptureImagePage(camera: camera),
    },
    initialRoute: "/",
  );

  runApp(app);

}*/
