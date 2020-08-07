import 'package:enc_flutter_2020_f1/tutorials/register-user.dart';
import 'package:flutter/material.dart';

class ConfirmUserDetails extends StatelessWidget {

  User user;

  //ConfirmUserDetails({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Extract arguments if pushed in from the previous widget :)
    user = ModalRoute.of(context).settings.arguments;

    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text("Register Yourself"),
        ),
        body: Center(
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Name: ${user.name}", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.orange),),
                      SizedBox(height: 8.0,),
                      Text("Email: ${user.email}", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.deepPurple),),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        width: size.width * 0.8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24.0),
                          child: RaisedButton(
                            child: Text("REGISTER ME", style: TextStyle(fontSize: 20.0, color: Colors.black),),
                            onPressed: (){

                            },
                          )
                        ),
                      )


                    ]
                )
            )
        )
    );
  }
}
