import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

Future<String> fetchCuisines() async {

  // Create the Object of http client which is required to send a network request
  http.Client client = http.Client();
  String apiKey = "cbf097dbf42b5614d37cee5909ec17c6";
  final url = "https://developers.zomato.com/api/v2.1/cuisines?city_id=20";

  // Network Request for data in headers :)
  final response = await client.get(url, headers: {
    'user-key': apiKey
  });

  // we wish to run parseJSONData as async function and as an ISOLATE
  return compute(parseJSONData, response.body);
}

// parseJSONData will be executed as an ISOLATE which means a thread with its separate memory resources and hence my app will not be slow :)
String parseJSONData(String json){

  // jsonDecode function -> converts string json data into Map of key value pair :)
  Map<String, dynamic> jsonData = jsonDecode(json);

  // articles is a list of Maps further
  //List cuisines = jsonData['cuisines'];

  // We are not doing any JSON Parsing here :(

  return jsonData.toString();
}

class ZomatoCuisinesPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cuisines"),
        ),
        body: FutureBuilder<String>(
          future: fetchCuisines(),  // Mention the Function which shall return future
          builder: (context, snapshot) {
            if(snapshot.hasError) return Center(child: Text("Something Went Wrong! Please Try Again !"),);
            return snapshot.hasData ? Center(child: Text(snapshot.data),) : Center(child: CircularProgressIndicator(),);
            // Try Implementing your regular Ladder if/else to show data for different states
          },
        )
    );
  }
}

/*
  Explore Zomato Developer Web Services
  Show Restaurants of a City with Reviews (Ascending Order)

  Page1 -> Shows all the Cities
  Page2 -> Shows Restaurants with reviews in some sorted arrangement for the clicked city in Page1 :)
 */

/*
  Project #1:
    Create an App which shows Fares for the same locations from OLA and Uber
    PS: Access to Location -> Latitude and Longitude (Monday -> Work on Locations)
 */