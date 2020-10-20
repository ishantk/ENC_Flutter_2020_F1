import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enc_flutter_2020_f1/constants/app-constants.dart';
import 'package:enc_flutter_2020_f1/util/utils.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Orders"),),
      body: Orders(),
    );
  }
}


class Orders extends StatelessWidget {
  FirebaseFirestore db = FirebaseFirestore.instance;
  fetchMyOrders(){
      return db.collection(Constants.ORDERS_COLLECTION).where('userID', isEqualTo: Utils.UID).snapshots();
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: fetchMyOrders(),
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
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(8.0),
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return InkWell(
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(height: 2.0,),
                      Text(document.data()['totalPrice'].toString(), style: TextStyle(fontSize: 24.0, color: Colors.amber),),
                      Text(document.data()['paymentOption'], style: TextStyle(fontSize: 20.0, color: Colors.amber),),
                      Divider(),
                      Text(document.data()['orderDateTime'].toString(), style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),),
                    ],
                  ),
                ),
              ),
              onTap: (){
                MaterialPageRoute route = MaterialPageRoute(builder: (context) => DishesInOrder(dishes: document.data()['dishes']),);
                Navigator.push(context, route);
              },
            );
          }).toList(),
        );

      },
    );
  }
}

class DishesInOrder extends StatelessWidget {

  var dishes = [];

  DishesInOrder({Key key, @required this.dishes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Orders"),),
      body: Container() // Display List of Dishes
    );
  }
}

