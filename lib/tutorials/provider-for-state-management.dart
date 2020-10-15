import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Lets create an object
// if we manipulate data in object, it must be notified

class Counter with ChangeNotifier{ // mixin

  int value = 0;

  void increment(){
    value += 1;
    notifyListeners(); // whenever we wish to notify to the subscriber about change in data i.e. change of state :)
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Provider",
      theme: ThemeData(
        primarySwatch: Colors.amber
      ),
      home: MyHomePage()
    );
  }
}


class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Provider Demo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Text("Counter Incremented Value"),
            Consumer<Counter>(
              builder: (context, counter, child) => Text("${counter.value}", style: TextStyle(fontSize: 20.0),)
            )
          ],

        )
      ),
     floatingActionButton: FloatingActionButton(
       onPressed: (){
         var counter = context.read<Counter>(); // Reference to the Counter Object
         counter.increment();
       },
       tooltip: "Increment Counter",
       child: Icon(Icons.add),
     ),
    );
  }
}
