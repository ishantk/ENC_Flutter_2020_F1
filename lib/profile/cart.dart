import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enc_flutter_2020_f1/constants/app-constants.dart';
import 'package:enc_flutter_2020_f1/payments/payment-options.dart';
import 'package:enc_flutter_2020_f1/payments/razorpay.dart';
import 'package:enc_flutter_2020_f1/profile/add-user-addresses.dart';
import 'package:enc_flutter_2020_f1/profile/user-addresses.dart';
import 'package:enc_flutter_2020_f1/restaurant/counter.dart';
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

  String payment = "Cash On Delivery";
  String address = "Default Address";
  int paymentIndex = 0;

  Order order = Order();

  placeOrder(List<Map<String, dynamic>> dishes){

    order.orderID = Utils.UID+"-"+DateTime.now().toString();
    order.userID = Utils.UID;
    order.restaurantID = dishes[0]['restaurantId'];
    order.orderDateTime = DateTime.now();
    order.orderState = 1; // 1 -> order in action | 2 -> order accepted by restaurant | 3 -> order picked by delivery agent | 4 -> order delivered to customer

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

              return Expanded(
                  child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                      image: NetworkImage(document.data()['imageURL']),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(2.0),),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(document.data()['title'], style: TextStyle(fontSize: 16.0, color: Colors.amber),),
                                Text(document.data()['totalPrice'].toString(), style: TextStyle(fontSize: 12.0, color: Colors.black),),
                                Text(document.data()['quantity'].toString(), style: TextStyle(fontSize: 12.0, color: Colors.blueGrey),),
                                Text(document.data()['description'], style: TextStyle(fontSize: 12.0, color: Colors.blueGrey),),
                                Text(document.data()['type'], style: TextStyle(fontSize: 12.0, color: Colors.blueGrey),),
                                Padding(padding: EdgeInsets.all(4.0),),
                              ],
                            ),
                            Counter(quantity: document.data()['quantity'], dishPrice: document.data()['price'], docId: document.id),
                          ],
                        ),
                      )
                  )
              );

              /*return Card(
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
              );*/
            }).toList(),
          );
        },
      ),

      bottomNavigationBar: Container(
        height: 150,
        padding: EdgeInsets.all(8.0),
        child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(address),
                OutlineButton(
                  child: Text("SELECT ADDRESS"),
                  onPressed: () async{
                    Map<String, dynamic> adrs = await Navigator.push(context, MaterialPageRoute(builder: (context) => UserAdressesPage(),));
                    setState(() {
                      address = adrs['label'];
                      order.deliveryAddress = adrs;
                    });
                  },
                )
              ],
            ),
            Padding(padding: EdgeInsets.all(2.0),),
            Divider(),
            Padding(padding: EdgeInsets.all(2.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlineButton(
                  child: Text(payment, style: TextStyle(color: Colors.amber),),
                  onPressed: () async{
                    Map<String, dynamic> paymentOption = await Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentOptionsPage(),));
                    setState(() {
                      payment = paymentOption['option'];
                      paymentIndex = paymentOption['index'];
                      order.paymentOption = payment;
                    });
                  },
                ),
                OutlineButton(
                    child: Text("PLACE ORDER >"),
                    onPressed: () async{

                      if(paymentIndex == 0){

                      }else if(paymentIndex == 1 || paymentIndex == 2 || paymentIndex == 3){
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
                      }else if(paymentIndex == 4){

                      }else if(paymentIndex == 5){

                      }else if(paymentIndex == 6){

                      }
                    }
                ),
              ],
            )
          ],
        )
      )
      )
    );
  }
}

