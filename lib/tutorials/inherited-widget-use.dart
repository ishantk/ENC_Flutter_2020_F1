import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: MyHomePage(
                child: MyButtonContainer(
                    child: MyContainer(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CounterLabelText(),
                              CounterValueText()
                            ]
                        )
                    )
                )
            )
        )
    );
  }
}

class MyHomePage extends StatefulWidget {

  final Widget child;
  const MyHomePage({Key key, @required this.child}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();

  static MyHomePageState of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<CounterInheritedWidget>().data;
  }
}

class MyHomePageState extends State<MyHomePage> {

  int counterValue = 0;
  int get counter => counterValue;

  void incrementCounter(){
    setState(() {
      counterValue += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CounterInheritedWidget(
      child: widget.child,
      data: this,
    );
  }
}

class CounterInheritedWidget extends InheritedWidget{

  // We have reference to HomePageState as data for us:)
  final MyHomePageState data;

  const CounterInheritedWidget({Key key, @required this.data, @required Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

}

class MyButtonContainer extends StatelessWidget{

  final Widget child;

  MyButtonContainer({Key key, @required this.child}): super(key : key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 100,
        child: RaisedButton(
          color: Colors.amber,
          child: child,
          onPressed: (){
            MyHomePage.of(context).incrementCounter();
          },
        )
      )
    );
  }
}

class MyContainer extends StatelessWidget {

  final Widget child;

  MyContainer({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }

}

class CounterLabelText extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Text("Counter", style: TextStyle(color: Colors.white, fontSize: 20));
  }
}

class CounterValueText extends StatefulWidget {
  @override
  CounterValueTextState createState() => CounterValueTextState();
}

class CounterValueTextState extends State<CounterValueText> {

  int counterValue;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    MyHomePageState pageState = MyHomePage.of(context);
    counterValue = pageState.counter;
  }

  @override
  Widget build(BuildContext context) {
    return Text("$counterValue", style: TextStyle(color: Colors.white, fontSize: 20));
  }
}


