import 'package:flutter/material.dart';

// From SecondPage Into FirstPage

class CountryPage extends StatefulWidget{
  createState() => CountryPageState();
}

class CountryPageState extends State<CountryPage>{

  String country = "NA";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text("CountryPage"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text("Select Your Country"),
              onPressed: () async{  // async function -> executed in the background and we can await for some result in this function

                MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => SelectCountryPage()
                );

                final result = await Navigator.push(context, route); // Push a New Widget in the Stack

                setState(() {
                  country = result.toString();
                  print("Country Is: $country");
                });

              },
            ),
            SizedBox(height: 4,),
            Text("Your Country: $country", style: TextStyle(fontSize: 20.0),)
          ],
        )

       ,
      ),
    );

  }
}

class SelectCountryPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        title: Text("Select Your Country"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              RaisedButton(
                child: Text("INDIA"),
                onPressed: (){                      // We can pass even user defined Object in pop function :)
                 Navigator.pop(context, "INDIA"); // Remove the Widget from the Stack by sending back the data India :)
                },
              ),
              RaisedButton(
                child: Text("USA"),
                onPressed: (){
                 Navigator.pop(context, "USA"); // Remove the Widget from the Stack by sending back the data India :)
                },
              ),
              RaisedButton(
                child: Text("CANADA"),
                onPressed: (){
                  Navigator.pop(context, "CANADA"); // Remove the Widget from the Stack by sending back the data India :)
                },
              )
          ],
        )
      ),
    );

  }
}