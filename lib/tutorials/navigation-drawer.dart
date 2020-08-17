import 'package:flutter/material.dart';


getStackWidget() => Card(
  child: Stack(
    alignment: Alignment(0.6, 0.6),
    children: [
      CircleAvatar(
        backgroundImage: AssetImage('assets/steve.png'),
        radius: 100,
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey
        ),
        child: Text("Steve Jobs",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300, color: Colors.white)
        ),
      )
    ],

  ),
);

//showAlertDialog is a user-defined function, we created it and can be nay name of your choice
showAlertDialog(BuildContext context){

  return showDialog( // showDialog is a built in builder function to build an AlertDialog
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Title of Dialog"),
          content: Text("This is the body of AlertDialog"),
          actions: [
            FlatButton(
              child: Text("Cancel"),
              onPressed: (){
                Navigator.pop(context); // Dismiss the Dialog
              },
            )
          ],
        );
      },
  );

}

void createAlertDialog(){
  AlertDialog dialog = AlertDialog(
    title: Text("Title of Dialog"),
    content: Text("This is the body of AlertDialog"),
    actions: [
      FlatButton(
        child: Text("Cancel"),
        onPressed: (){

        },
      )
    ],
  );

  // We have created an AlertDialog Widget separately.
  // How can we show it on Button Click ?
}

class NavigationDrawerPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Navigation Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text("Show Alert Dialog"),
              onPressed: (){
                //showAlertDialog(context);
                showDialog( // showDialog is a built in builder function to build an AlertDialog
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Title of Dialog"),
                      content: Text("This is the body of AlertDialog"),
                      actions: [
                        FlatButton(
                          child: Text("Cancel"),
                          onPressed: (){
                            Navigator.pop(context); // Dismiss the Dialog
                          },
                        )
                      ],
                    );
                  },
                );
              },
            ),
            Padding(padding: EdgeInsets.all(16.0),),
            RaisedButton(
              child: Text("Show Bottom Sheet"),
              onPressed: (){
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 240,
                        color: Colors.amberAccent,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("This is a Model Bottom Sheet"),
                              Padding(padding: EdgeInsets.all(16.0),),
                              FlatButton(
                                child: Text("Close"),
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        ),
                      );
                    },
                );
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: getStackWidget(),
              ),
              decoration: BoxDecoration(
                color: Colors.amberAccent
              ),
            ),
            ListTile(
              title: Text("Login"),
              subtitle: Text("Login to the App"),
              leading: Icon(Icons.security),
              trailing: Icon(Icons.arrow_right),
              onTap: (){

              },
            ),
            ListTile(
              title: Text("Home"),
              subtitle: Text("Navigate to Home Page"),
              leading: Icon(Icons.home),
              trailing: Icon(Icons.arrow_right),
              onTap: (){
                Navigator.pushNamed(context, "/zomato");
              },
            ),
            ListTile(
              title: Text("News"),
              subtitle: Text("Check the Latest News"),
              leading: Icon(Icons.chrome_reader_mode),
              trailing: Icon(Icons.arrow_right),
              onTap: (){
                Navigator.pop(context); // Close the Open Drawer First
                Navigator.pushNamed(context, "/json");
              },
            )
          ],
        ),
      ),
    );
  }
}

