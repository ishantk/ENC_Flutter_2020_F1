import 'package:enc_flutter_2020_f1/constants/app-constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePageWithFilters extends StatefulWidget {
  @override
  _HomePageWithFiltersState createState() => _HomePageWithFiltersState();
}

class _HomePageWithFiltersState extends State<HomePageWithFilters> {
  @override
  Widget build(BuildContext context) {

    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference collectionRestaurants = db.collection(Constants.RESTAURANT_COLLECTION);

    return ListView(
      padding: EdgeInsets.all(16.0),
      scrollDirection: Axis.vertical,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(8.0),
            children: [
              RaisedButton(
                child: Text(
                  "Vegetarian", style: TextStyle(fontSize: 18.0,),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: BorderSide(color: Colors.blueGrey)
                ),
                onPressed: (){

                },
              ),
              RaisedButton(
                child: Text(
                  "Non Vegetarian", style: TextStyle(fontSize: 18.0,),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: Colors.blueGrey)
                ),
                onPressed: (){

                },
              ),
              RaisedButton(
                child: Text(
                  "Trending", style: TextStyle(fontSize: 18.0,),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: Colors.blueGrey)
                ),
                onPressed: (){

                },
              ),
              RaisedButton(
                child: Text(
                  "Top5", style: TextStyle(fontSize: 18.0,),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: Colors.blueGrey)
                ),
                onPressed: (){

                },
              ),
            ],
          ),
        ),
        SizedBox(height: 4.0,),
        StreamBuilder<QuerySnapshot>(
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
        )
      ],
    );
  }
}
