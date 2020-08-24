import 'package:flutter/material.dart';

class BannerPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Banner"),
      ),
      body: MaterialBanner(
        content: Text("We are not working on Weekends."),
        leading: CircleAvatar(child: Icon(Icons.notifications),),
        actions: [
          FlatButton(
            child: Text("Done"),
            onPressed: (){

            },
          ),
          FlatButton(
            child: Text("Order Now"),
            onPressed: (){

            },
          )
        ],
      ),
    );
  }

}