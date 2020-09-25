import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enc_flutter_2020_f1/constants/app-constants.dart';
import 'package:enc_flutter_2020_f1/util/utils.dart';
import 'package:flutter/material.dart';


class UserAdressesPage extends StatefulWidget {
  @override
  _UserAdressesPageState createState() => _UserAdressesPageState();
}

class _UserAdressesPageState extends State<UserAdressesPage> {

  Future<Map<String, dynamic>> fetchUser() async{

    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentReference documentReference = db.collection(Constants.USERS_COLLECTION).doc(Utils.UID);
    DocumentSnapshot documentSnapshot = await documentReference.get();

    Map<String, dynamic> document = documentSnapshot.data();

    print("DOCUMENT: ${document.toString()}");

    return document; // contains information of entire restaurant
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Addresses"),
      ),
      body: FutureBuilder(
        future: fetchUser(),
        builder: (context, snapshot){
          if (snapshot.hasError) return Center(child: Text("Something Went Wrong"),);
          return snapshot.hasData ? AddressList(document: snapshot.data) : Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}

class AddressList extends StatefulWidget {

  Map<String, dynamic> document;

  AddressList({Key key, @required this.document}) : super(key: key);

  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      itemCount: widget.document['addresses'].length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(widget.document['addresses'][index]['label'], style: TextStyle(fontSize: 18.0, color: Colors.amber),),
          subtitle: Text(widget.document['addresses'][index]['adrsLine'], style: TextStyle(fontSize: 14.0, color: Colors.blueGrey),),
          leading: Icon(Icons.home),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: (){
            Navigator.pop(context, widget.document['addresses'][index]);
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
