import 'package:enc_flutter_2020_f1/constants/app-constants.dart';
import 'package:enc_flutter_2020_f1/util/utils.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
          title: Text(Constants.SIGNIN_TITLE),
        ),
        body: internet
            ? Form()
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
}
