import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

fetchNews() async {

  // Create the Object of http client which is required to send a network request
  http.Client client = http.Client();
  final url = "http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=";
  // till time we do not get http response, we will not execute any statement further
  final response = await client.get(url);

  // This will be printed in the Logcat :)
  print(response.body);
}

class NewsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Fetch News"),
          onPressed: (){
            fetchNews(); // this functions runs in the background parallel to the main ui thread
          },
        ),
      ),
    );
  }
}
