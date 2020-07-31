import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SnackBarPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("SnackBar"),
      ),
      body: SnackBarWidget(),
    );

  }
}

class SnackBarWidget extends StatelessWidget{

  // we can use DateTime API in our App to show the time stamps
  // var now = DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(//RaisedButton(
        child: Text("Click Me"),
        onPressed: (){
          final snackBar = SnackBar(
            content: Text("This is Awesome :)"),
            action: SnackBarAction(
              label: "Exit",
              onPressed: (){
                SystemNavigator.pop(); // exit
              },
            ),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        },
      ),
    );
  }
}