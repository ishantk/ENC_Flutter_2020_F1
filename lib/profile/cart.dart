import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enc_flutter_2020_f1/constants/app-constants.dart';
import 'package:enc_flutter_2020_f1/util/utils.dart';
import 'package:flutter/material.dart';

class DishCartPage extends StatefulWidget {
  @override
  _DishCartPageState createState() => _DishCartPageState();
}

class _DishCartPageState extends State<DishCartPage> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference collectionRestaurants = db.collection(Constants.USERS_COLLECTION).doc(Utils.UID).collection(Constants.CART_COLLECTION);

    return Scaffold(
      appBar: AppBar(
        title: Text("CART"),
      ),
      body: StreamBuilder<QuerySnapshot>(
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

          return ListView(
            padding: EdgeInsets.all(8.0),
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return Card(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.network(document.data()['imageURL']),
                      SizedBox(height: 2.0,),
                      Text(document.data()['title'], style: TextStyle(fontSize: 24.0, color: Colors.amber),),
                      Counter(quantity: document.data()['quantity'], dishPrice: document.data()['price'], docId: document.id),
                      Text(document.data()['price'].toString(), style: TextStyle(fontSize: 16.0, color: Colors.blueGrey),),
                      Text(document.data()['totalPrice'].toString(), style: TextStyle(fontSize: 20.0, color: Colors.black),),
                      Text(document.data()['description'], style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),),
                      Divider(),
                      Text(document.data()['type'], style: TextStyle(fontSize: 20.0, color: Colors.blueGrey),),
                    ],
                  ),
                ),
              );
            }).toList(),
          );

        },
      ),
    );
  }
}

class Counter extends StatefulWidget {

  int quantity;
  int dishPrice;
  String docId;

  Counter({Key key, @required this.quantity, @required this.dishPrice, @required this.docId}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {

  FirebaseFirestore db = FirebaseFirestore.instance;
  
  updateDishQuantityInFirestore(){
    CollectionReference cart = db.collection(Constants.USERS_COLLECTION).doc(Utils.UID).collection(Constants.CART_COLLECTION);
    cart.doc(widget.docId).update({"quantity": widget.quantity, "totalPrice":widget.quantity*widget.dishPrice}).then((value) {
      // show some snackbar for update
    });

  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FlatButton(
            child: Text('-', style: TextStyle(fontSize: 20.0),),
            onPressed: (){
              setState(() {
                if(widget.quantity>1){
                  widget.quantity -= 1;
                  updateDishQuantityInFirestore();
                }
              });
            },
          ),
          Padding(padding: EdgeInsets.all(2.0),),
          Text('${widget.quantity}', style: TextStyle(fontSize: 20.0),),
          Padding(padding: EdgeInsets.all(2.0),),
          FlatButton(
            child: Text('+', style: TextStyle(fontSize: 20.0),),
            onPressed: (){
              setState(() {
              if(widget.quantity<10) {
                widget.quantity += 1;
                updateDishQuantityInFirestore();
              }
              });
            },
          )
        ],
      ),
    );
  }
}

