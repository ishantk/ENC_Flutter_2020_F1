import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Container"),
        ),
        body: Center(child: getCard(context)));
  }
}

getCard(BuildContext context) => Expanded(
      // Automatically help us to manage height of the Widgets as per the UI
      child: Card(
        color: Colors.grey,
        shadowColor: Colors.blueGrey,
        margin: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  border: Border.all(width: 3, color: Colors.black)),
              child: Image.asset("assets/larry.png"),
              margin: EdgeInsets.all(4),
            ),
            ListTile(
              title: Text(
                "Larry Page",
                style: TextStyle(fontSize: 24.0, color: Colors.amber),
              ),
              subtitle: Text("Google"),
              leading: Icon(
                Icons.contact_mail,
                color: Colors.amberAccent,
              ),
            ),
            SizedBox(
              height: 2.0,
            ),
            Divider(),
            SizedBox(
              height: 2.0,
            ),
            ListTile(
              title: Text(
                "larry.page@google.com",
                style: TextStyle(fontSize: 24.0, color: Colors.amber),
              ),
              subtitle: Text("San Jose, California"),
            ),
          ],
        ),
      ),
    );
