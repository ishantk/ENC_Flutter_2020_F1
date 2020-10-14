import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enc_flutter_2020_f1/constants/app-constants.dart';
import 'package:enc_flutter_2020_f1/util/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


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
      Fluttertoast.showToast(msg: "Quantity Updated to ${widget.quantity}",);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.black12,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              child: Icon(Icons.remove, size: 16.0,),
              onTap: (){
                setState(() {
                  if(widget.quantity>1){
                    widget.quantity -= 1;
                    updateDishQuantityInFirestore();
                  }
                });
              },
            ),
            Padding(padding: EdgeInsets.all(2.0),),
            Text('${widget.quantity}', style: TextStyle(fontSize: 16.0, color: Colors.orangeAccent),),
            Padding(padding: EdgeInsets.all(2.0),),
            InkWell(
              child: Icon(Icons.add, size: 16.0,),
              onTap: (){
                setState(() {
                  if(widget.quantity<10) {
                    widget.quantity += 1;
                    updateDishQuantityInFirestore();
                  }
                });
              },
            ),
          ],
        ),
      );
  }
}