import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enc_flutter_2020_f1/constants/app-constants.dart';
import 'package:enc_flutter_2020_f1/payments/razorpay.dart';
import 'package:enc_flutter_2020_f1/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:enc_flutter_2020_f1/model/order.dart';

class DishCartPage extends StatefulWidget {
  @override
  _DishCartPageState createState() => _DishCartPageState();
}

class _DishCartPageState extends State<DishCartPage> {

  FirebaseFirestore db = FirebaseFirestore.instance;

  placeOrder(List<Map<String, dynamic>> dishes){

    Order order = Order();
    order.orderID = Utils.UID+"-"+DateTime.now().toString();
    order.userID = Utils.UID;
    order.restaurantID = dishes[0]['restaurantId'];
    order.orderDateTime = DateTime.now();

    order.totalPrice = 0;

    for(int i=0;i<dishes.length;i++){
      order.totalPrice += dishes[i]['totalPrice'];
    }

    order.dishes = dishes;


    db.collection(Constants.ORDERS_COLLECTION).add(order.toMap()).then((value){

      Fluttertoast.showToast(
          msg: "Order Placed Successfully "+order.orderID,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

      // Initially Place the Order and afterwards clear the cart collection :)
      removeDishesFromCart();

    });

  }

  removeDishesFromCart(){
    db.collection(Constants.USERS_COLLECTION).doc(Utils.UID).collection(Constants.CART_COLLECTION).get().then((QuerySnapshot querySnapshot){
      List<QueryDocumentSnapshot> docs = querySnapshot.docs;
      for(int i=0;i<docs.length;i++){
        String docId = docs[i].id;
        db.collection(Constants.USERS_COLLECTION).doc(Utils.UID).collection(Constants.CART_COLLECTION).doc(docId).delete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference collectionRestaurants = db.collection(Constants.USERS_COLLECTION).doc(Utils.UID).collection(Constants.CART_COLLECTION);

    int amount = 0;
    List<Map<String, dynamic>> dishes = [];

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

              amount += document.data()['totalPrice'];
              dishes.add(document.data());

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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: RaisedButton(
          child: Text("CONFIRM ORDER"),
          onPressed: () async{
            String message = await Navigator.push(context, MaterialPageRoute(builder: (context) => RazorPayCheckoutPage(amount: amount),));

            if(message.contains("SUCCESS")){
              placeOrder(dishes);
            }else if(message.contains("WALLET")){
              placeOrder(dishes);
            }else{
              Fluttertoast.showToast(
                  msg: "Something Went Wrong: "+message,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          }
        ),
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

