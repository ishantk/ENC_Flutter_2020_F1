import 'package:flutter/material.dart';

/*
class GesturePage extends StatelessWidget {

  final scffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GridList Page"),
      ),
      key: scffoldKey,
      body: Center(
          child: GestureDetector(
              child: Card(
        margin: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Welcome to Gesture Page"),
            Padding(
              padding: EdgeInsets.all(4.0),
            ),
            Divider(),
            Text("Work Hard, Get Luckier")
          ],
        ),
      ),
            onTap: (){
                Navigator.pushNamed(context, '/gridlist');
            },
            onLongPress: (){
                final snackBar = SnackBar(
                  content: Text("This is a Long Press Event"),
                );
                scffoldKey.currentState.showSnackBar(snackBar);
            },
            onDoubleTap: (){

            },
          )
      ),
    );
  }
}
*/


class GesturePage extends StatelessWidget {

  final scffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GridList Page"),
      ),
      key: scffoldKey,
      body: Center(
          child: InkWell(
            child: Card(
              margin: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Welcome to Gesture Page"),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Divider(),
                  Text("Work Hard, Get Luckier")
                ],
              ),
            ),
            onTap: (){
              Navigator.pushNamed(context, '/gridlist');
            },
            onLongPress: (){
              final snackBar = SnackBar(
                content: Text("This is a Long Press Event"),
              );
              scffoldKey.currentState.showSnackBar(snackBar);
            },
            onDoubleTap: (){

            },
          )
      ),
    );
  }
}
