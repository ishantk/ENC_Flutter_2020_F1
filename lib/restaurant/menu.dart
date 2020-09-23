import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enc_flutter_2020_f1/constants/app-constants.dart';
import 'package:enc_flutter_2020_f1/profile/cart.dart';
import 'package:enc_flutter_2020_f1/util/utils.dart';
import 'package:flutter/material.dart';

// RestaurantMenuPage will re-fetch the data from the backend

class RestaurantMenuPage extends StatefulWidget {

  String restaurantId;

  RestaurantMenuPage({Key key, @required this.restaurantId}) : super(key: key);

  @override
  _RestaurantMenuPageState createState() => _RestaurantMenuPageState();
}

class _RestaurantMenuPageState extends State<RestaurantMenuPage> {

  Future<Map<String, dynamic>> fetchRestaurantData() async{

    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentReference documentReference = db.collection(Constants.RESTAURANT_COLLECTION).doc(widget.restaurantId);
    DocumentSnapshot documentSnapshot = await documentReference.get();

    Map<String, dynamic> document = documentSnapshot.data();

    print("DOCUMENT: ${document.toString()}");

    return document; // contains information of entire restaurant
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
      ),
      body: FutureBuilder(
        future: fetchRestaurantData(),
        builder: (context, snapshot){
          if (snapshot.hasError) return Center(child: Text("Something Went Wrong"),);
          return snapshot.hasData ? Dishes(restaurant: snapshot.data) : Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}

class Dishes extends StatefulWidget {

  Map<String, dynamic> restaurant;

  Dishes({Key key, @required this.restaurant}) : super(key: key);

  @override
  _DishesState createState() => _DishesState();
}

class _DishesState extends State<Dishes> {
  @override
  Widget build(BuildContext context) {

    print("Restaurant Menu Length: ${widget.restaurant['menu'].length}");

    return ListView.separated(
      itemCount: widget.restaurant['menu'].length,
      itemBuilder: (context, index) {
        return Card(
            margin: EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.network(widget.restaurant['menu'][index]['imageURL']),
                  SizedBox(height: 2.0,),
                  Text(widget.restaurant['menu'][index]['title'], style: TextStyle(fontSize: 20.0, color: Colors.amber),),
                  Text(widget.restaurant['menu'][index]['price'].toString(), style: TextStyle(fontSize: 18.0, color: Colors.black),),
                  Text(widget.restaurant['menu'][index]['description'], style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),),
                  Divider(),
                  Text(widget.restaurant['menu'][index]['type'], style: TextStyle(fontSize: 20.0, color: Colors.blueGrey),),
                  Padding(padding: EdgeInsets.all(4.0),),
                  FlatButton(
                    child: Text("ADD TO CART"),
                    onPressed: (){

                    },
                  )
                ],
              ),
            ),
          );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },

    );
  }
}

// RestaurantDishes will directly get the restaurant Object from the restaurant list

class RestaurantDishes extends StatefulWidget {

  Map<String, dynamic> restaurant;
  String restaurantID;

  RestaurantDishes({Key key, @required this.restaurant, @required this.restaurantID}) : super(key: key);

  @override
  _RestaurantDishesState createState() => _RestaurantDishesState();
}

class _RestaurantDishesState extends State<RestaurantDishes> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            tooltip: "CART",
            onPressed: (){
              MaterialPageRoute route = MaterialPageRoute(builder: (context) => DishCartPage());
              Navigator.push(context, route);
            },
          )
        ],
      ),
      body: ListView.separated(
        itemCount: widget.restaurant['menu'].length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.network(widget.restaurant['menu'][index]['imageURL']),
                  SizedBox(height: 2.0,),
                  Text(widget.restaurant['menu'][index]['title'], style: TextStyle(fontSize: 20.0, color: Colors.amber),),
                  Text(widget.restaurant['menu'][index]['price'].toString(), style: TextStyle(fontSize: 18.0, color: Colors.black),),
                  Text(widget.restaurant['menu'][index]['description'], style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),),
                  Divider(),
                  Text(widget.restaurant['menu'][index]['type'], style: TextStyle(fontSize: 20.0, color: Colors.blueGrey),),
                  Padding(padding: EdgeInsets.all(4.0),),
                  RaisedButton(
                    child: Text("ADD TO CART"),
                    onPressed: (){

                      // Cart is a Collection where we will save the dishes of the User

                      // On press we get the entire map in dishData
                      var dishData = widget.restaurant['menu'][index];
                      dishData['quantity'] = 1;
                      dishData['restaurant'] = widget.restaurant['name'];
                      dishData['restaurantId'] = widget.restaurantID;
                      dishData['totalPrice'] = widget.restaurant['menu'][index]['price'];

                      FirebaseFirestore db = FirebaseFirestore.instance;
                      db.collection(Constants.USERS_COLLECTION).doc(Utils.UID).collection(Constants.CART_COLLECTION).add(dishData)
                          .then((value){
                          print("Document Added");
                          //Show a SnackBar :)
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                      side: BorderSide(color: Colors.amber)
                    ),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      )
    );

  }
}

