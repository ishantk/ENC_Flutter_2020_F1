import 'package:flutter/material.dart';

class PageOne extends StatelessWidget{

  //getWidget(BuildContext context) => PageTwo();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text("PageOne"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Open Next Page"),
          onPressed: (){

            // MaterialPageRoute -> Intent in Android
            // Navigator.push -> startActivity()

            //MaterialPageRoute route = MaterialPageRoute(builder: getWidget); // Either Pass the Function Reference
            //MaterialPageRoute route = MaterialPageRoute(
            //  builder: (context) => PageTwo()
            //);

            //Navigator.push(context, route); // Push a New Widget in the Stack
            Navigator.pushNamed(context, "/pagetwo");
          },
        ),
      ),
    );

  }
}

class PageTwo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        title: Text("PageTwo"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Exit"),
          onPressed: (){
            Navigator.pop(context); // Remove the Widget from the Stack :)
          },
        ),
      ),
    );

  }
}