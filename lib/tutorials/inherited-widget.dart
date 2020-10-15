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
        home: MyHomePage()
    );
  }
}


// Immutable Widget
// We cannot change anything in this Widget
// BUT, this can have data as reference which may be modified
class CounterInheritedWidget extends InheritedWidget{

  // Constructor for InheritedWidget
  const CounterInheritedWidget({Key key, @required this.data, @required Widget child}) : super(key: key, child: child);

  // data is int type but it can be reference to any other object containing data :)
  final int data;

  // static of function which gives reference to CounterInheritedWidget and hence we can access data in it :)
  static CounterInheritedWidget of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<CounterInheritedWidget>();
  }

  @override
  bool updateShouldNotify(CounterInheritedWidget old) => data != old.data;

}


class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CounterInheritedWidget(
            data: 10,
            child: Builder(
                builder: (BuildContext innerContext){
                  return Text(
                      "HELLO WORLD ${CounterInheritedWidget.of(innerContext).data}"
                  );
                }
            )
        )
    );
  }
}
