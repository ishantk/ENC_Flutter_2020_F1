//import 'package:camera/camera.dart';
//import 'package:enc_flutter_2020_f1/tutorials/application.dart';
//import 'package:enc_flutter_2020_f1/tutorials/capture-image.dart';
//import 'package:flutter/cupertino.dart';

import 'package:enc_flutter_2020_f1/provider-tutorial/menu-ui.dart';
import 'package:enc_flutter_2020_f1/tutorials/provider-for-state-management.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:enc_flutter_2020_f1/auth/food-delivery-app.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // This is new implementation from Firebase
  runApp(FoodDeliveryApp());

  /*runApp(
    ChangeNotifierProvider(
      create: (context) => Counter(), // Construct the Objects when we run the App
      child: MyApp(),
    )
  );*/

  //runApp(MyFoodMenuApp());

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
