import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enc_flutter_2020_f1/constants/app-constants.dart';
import 'package:enc_flutter_2020_f1/util/utils.dart';
import 'package:flutter/material.dart';


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
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FlatButton(
              child: Text('-', style: TextStyle(fontSize: 16.0),),
              onPressed: (){
                setState(() {
                  if(widget.quantity>1){
                    widget.quantity -= 1;
                    updateDishQuantityInFirestore();
                  }
                });
              },
            ),
            Text('${widget.quantity}', style: TextStyle(fontSize: 14.0),),
            FlatButton(
              child: Text('+', style: TextStyle(fontSize: 16.0),),
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
        );
  }
}