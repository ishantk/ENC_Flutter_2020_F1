import 'package:flutter/material.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

// Managing State of Widget
// Updating the State of One Widget from the Other
// Keys to Manage the state
// Parent Widget and Child Widget Hierarchy

// Parent Widget
class HomePage extends StatefulWidget{
  HomePageState createState() => HomePageState();
}

class HomePageState  extends State<HomePage> {

  GlobalKey<MyWidgetState> key = GlobalKey<MyWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("State Management")),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlineButton(
                  child: Text("Click To Change"),
                  onPressed: (){
                    key.currentState.changeText("Hello World is Awesome");
                  }
              ),
              Padding(padding: EdgeInsets.all(4.0)),
              MyWidget(key: key),
            ]
        ),
      ),
    );
  }
}

// Child Widget
class MyWidget extends StatefulWidget{

  MyWidget({Key key}): super(key: key);

  MyWidgetState createState() => MyWidgetState();
}

class MyWidgetState extends State<MyWidget> {

  String text = 'Hello, World!';

  changeText(String data){
    setState((){
      text = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.headline4);
  }
}
