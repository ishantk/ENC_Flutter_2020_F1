import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enc_flutter_2020_f1/constants/app-constants.dart';
import 'package:flutter/material.dart';

class RestaurantPage extends StatefulWidget {
  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {

  @override
  Widget build(BuildContext context) {

    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference collectionRestaurants = db.collection(Constants.RESTAURANT_COLLECTION);

    return StreamBuilder<QuerySnapshot>(
        stream: collectionRestaurants.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

          if(snapshot.hasError){
            return Center(
              child: Text("Something Went Wrong. Please Try Again !!"),
            );
          }

          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator()
            );
          }

          // ListView with ListTile
          /*return ListView(
            padding: EdgeInsets.all(16.0),
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return ListTile(
                title: Text(document.data()['name']),
                subtitle: Text(document.data()['pricePerPerson']),
              );
            }).toList(),
          );*/

          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(16.0),
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return InkWell(
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image.network(document.data()['imageURL']),
                        SizedBox(height: 2.0,),
                        Text(document.data()['name'], style: TextStyle(fontSize: 24.0, color: Colors.amber),),
                        Text("PricePerPerson ${document.data()['pricePerPerson']}", style: TextStyle(fontSize: 18.0, color: Colors.black),),
                        Text("Ratings: ${document.data()['ratings']}", style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),),
                        Divider(),
                        Text("${document.data()['addresses'][0]['city']} | ${document.data()['addresses'][0]['label']}", style: TextStyle(fontSize: 20.0, color: Colors.blueGrey),),
                      ],
                    ),
                  ),
                ),
                onTap: (){
                  // Navigate to the Menu of this Restaurant :)
                },
              );
            }).toList(),
          );

        },
      );
  }
}
