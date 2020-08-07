import 'package:enc_flutter_2020_f1/tutorials/details-user.dart';
import 'package:flutter/material.dart';


class User{

  String name;
  String email;
  String password;

  User({this.name, this.email, this.password});

  @override
  String toString() {
    return "Name: $name | Email: $email | Password: $password";
  }

}


class RegisterPage extends StatelessWidget{

  User user = User(name:"NA", email:"NA", password:"NA");

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(

      appBar: AppBar(title: Text("Register Yourself"),),

      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/app_icon.png'),
              SizedBox(height: 2.0,),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                padding: EdgeInsets.all(16.0),
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  borderRadius: BorderRadius.circular(24.0)
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Enter Your Name",
                  ),
                  controller: controllerName,
                ),
              ),
              SizedBox(height: 2.0,),
              TextField(
                decoration: InputDecoration(
                  labelText: "Enter Your Email",
                ),
                controller: controllerEmail,
              ),
              SizedBox(height: 2.0,),
              TextField(
                decoration: InputDecoration(
                  labelText: "Enter Your Password",
                ),
                obscureText: true,
                controller: controllerPassword,
                /*onChanged: (value){

                },*/
              ),
              SizedBox(height: 4.0,),
              RaisedButton(
                child: Text("NEXT >"),
                onPressed: (){
                    user.name = controllerName.text;
                    user.email = controllerEmail.text;
                    user.password = controllerPassword.text;

                    // prints data on logcat
                    print("USER DATA:");
                    print(user.toString());

                    // Using API, MaterialPageRoute :)
                    //MaterialPageRoute route = MaterialPageRoute(builder: (context) => ConfirmUserDetails(user:user));
                    //Navigator.push(context, route);

                    //Navigator.pushNamed(context, "/details");
                    // Pass the Data to the next Widget in Stack :)
                    Navigator.pushNamed(context, "/details", arguments: user);

                },
              )
            ],
          ),
        )
      )
    );
  }
}