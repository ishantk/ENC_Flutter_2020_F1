import 'package:enc_flutter_2020_f1/constants/app-constants.dart';
import 'package:enc_flutter_2020_f1/util/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget{
  createState()=>_SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool internet = false;

  @override
  void initState() {
    super.initState();

    Utils.isInternetConnected().then((bool value) {
      internet = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Constants.choice["SIGNUP_TITLE"]),
        ),
        body: internet
            ? Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 6.0,
                ),
                Icon(Icons.local_bar),
                SizedBox(
                  height: 2.0,
                ),
                Text(Constants.choice["REGISTER_TITLE"]),
                SizedBox(
                  height: 2.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Enter Name",
                  ),
                  controller: nameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please Enter Name"; // return error message
                    }
                    return null; // here no error message
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Enter Email",
                  ),
                  controller: emailController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please Enter Email"; // return error message
                    } else {
                      if (!value.contains("@") && !value.contains(".")) {
                        // implement regex to check if email is correctly enetered or not
                        return "Email is not Valid";
                      }
                    }
                    return null; // here no error message
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Enter Password",
                  ),
                  controller: passwordController,
                  obscureText: true,
                  // Implement a functionality in the right of TextFormField to show/hide the Password
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please Enter Password"; // return error message
                    } else {
                      if (value.length <= 5) {
                        return "Password should be min 6 characters";
                      }
                    }
                    return null; // here no error message
                  },
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: RaisedButton(
                    child: Text("REGISTER"),
                    onPressed: () async{
                      if (formKey.currentState.validate()) {
                        // if no errors :)
                        User user = await registerUser(emailController.text, passwordController.text);
                        if(user!=null){
                          // Register is a Success
                          print("Registration Success");
                        }else{
                          print("Registration Failed");
                        }
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        )
            : Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.signal_wifi_off,
                    color: Colors.redAccent,
                    size: 80,
                  ),
                  Text("Seems Like You Are Not Connected to Internet"),
                  Text("Please Connect to Internet and Try Again"),
                ],
              ),
            )));
  }

  Future<User> registerUser(String email, String password){
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.createUserWithEmailAndPassword(email: email, password: password).then((UserCredential value){
      // User -> is from FirebaseAuth Library
      User user = value.user;
      return user;
    });
  }

}
