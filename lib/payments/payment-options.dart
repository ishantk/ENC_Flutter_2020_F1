import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enc_flutter_2020_f1/constants/app-constants.dart';
import 'package:flutter/material.dart';

class PaymentOptionsPage extends StatefulWidget {
  @override
  _PaymentOptionsPageState createState() => _PaymentOptionsPageState();
}

class _PaymentOptionsPageState extends State<PaymentOptionsPage> {

  Future<Map<String, dynamic>> fetchPaymentOptions() async{

    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentReference documentReference = db.collection(Constants.CONFIG_COLLECTION).doc(Constants.PAYMENT_OPTIONS_DOC);
    DocumentSnapshot documentSnapshot = await documentReference.get();

    Map<String, dynamic> document = documentSnapshot.data();

    print("DOCUMENT: ${document.toString()}");

    return document; // contains information of entire restaurant
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Methods"),
      ),
      body: FutureBuilder(
        future: fetchPaymentOptions(),
        builder: (context, snapshot){
          if (snapshot.hasError) return Center(child: Text("Something Went Wrong"),);
          return snapshot.hasData ? PaymentOptions(document: snapshot.data) : Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}

class PaymentOptions extends StatefulWidget {

  Map<String, dynamic> document;

  PaymentOptions({Key key, @required this.document}) : super(key: key);

  @override
  _PaymentOptionsState createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      itemCount: widget.document['options'].length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(widget.document['options'][index], style: TextStyle(fontSize: 18.0),),
          leading: Icon(Icons.payment),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: (){
            Navigator.pop(context, {"index":index, "option":widget.document['options'][index]});
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
