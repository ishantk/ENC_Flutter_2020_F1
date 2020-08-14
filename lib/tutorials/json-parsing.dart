import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/*
Future<String> fetchNews() async {

  // Create the Object of http client which is required to send a network request
  http.Client client = http.Client();
  final url = "http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=31c21508fad64116acd229c10ac11e84";
  // till time we do not get http response, we will not execute any statement further
  final response = await client.get(url);

  // This will be printed in the Logcat :)
  //print(response.body);
  return response.body;
}*/

Future<List<News>> fetchNews() async {

  // Create the Object of http client which is required to send a network request
  http.Client client = http.Client();
  final url = "http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=31c21508fad64116acd229c10ac11e84";
  // till time we do not get http response, we will not execute any statement further
  final response = await client.get(url);

  // we wish to run parseJSONData as async function and as an ISOLATE
  return compute(parseJSONData, response.body);
}

// parseJSONData will be executed as an ISOLATE which means a thread with its separate memory resources and hence my app will not be slow :)
List<News> parseJSONData(String json){

  // jsonDecode function -> converts string json data into Map of key value pair :)
  Map<String, dynamic> jsonData = jsonDecode(json);

  // articles is a list of Maps further
  List articles = jsonData['articles'];

  /*
  // create an empty news list
  List newsList = [];
  for(int i=0;i<articles.length;i++){
    var newsArticle = articles[i]; // articles[i] is a Map of key value pair
    News news = News.fromMap(newsArticle);
    newsList.add(news);
  }
  */

  // built in map function within dart which will help us to map data as News Object
  //List<News> newsList = articles.map<News>((data) => News.fromMap(data)).toList();
  // return newsList;

  return articles.map<News>((data) => News.fromMap(data)).toList();
}



/*
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
}*/

/*
// We are displaying JSON Data in our UI
class NewsAPIPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: FutureBuilder<String>(
        future: fetchNews(),  // Mention the Function which shall return future
        builder: (context, snapshot) {
          if(snapshot.hasError) return Center(child: Text("Something Went Wrong! Please Try Again !"),);
          return snapshot.hasData ? Center(child: Text(snapshot.data),) : Center(child: CircularProgressIndicator(),);
          // Try Implementing your regular Ladder if/else to show data for different states
        },
      )
    );
  }
}*/

class NewsAPIPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("News"),
        ),
        body: FutureBuilder<List<News>>(
          future: fetchNews(),  // Mention the Function which shall return future
          builder: (context, snapshot) {
            if(snapshot.hasError) return Center(child: Text("Something Went Wrong! Please Try Again !"),);
            return snapshot.hasData ? NewsAPIList(news: snapshot.data) : Center(child: CircularProgressIndicator(),);
            // Try Implementing your regular Ladder if/else to show data for different states
          },
        )
    );
  }
}

/*

class NewsAPIList extends StatelessWidget{

  List<News> news;

  NewsAPIList({Key key, @required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: news.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(news[index].title),
          subtitle: Text(news[index].author),
          leading: Icon(Icons.message),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },

    );
  }
}

*/

class NewsAPIList extends StatelessWidget{

  List<News> news;

  NewsAPIList({Key key, @required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: news.length,
      itemBuilder: (context, index) {

        return InkWell(
          child: Card(
            margin: EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.network(news[index].urlToImage),
                  SizedBox(height: 6.0,),
                  Divider(),
                  SizedBox(height: 6.0,),
                  Text(news[index].title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black), ),
                  Divider(),
                  Text(news[index].author, style: TextStyle(fontSize: 18.0, color: Colors.amber)),
                  Text(news[index].description),
                  Divider(),
                  Text(news[index].publishedAt, style: TextStyle(fontSize: 18.0, color: Colors.blueGrey)),
                ],
              ),
            ),
          ),
          onTap: (){
            MaterialPageRoute route = MaterialPageRoute(builder: (context) => NewsWebPage(url: news[index].url),);
            Navigator.push(context, route);
          },
        );

      },
      separatorBuilder: (context, index) {
        return Divider();
      },

    );
  }
}

class NewsWebPage extends StatelessWidget{

  String url;

  NewsWebPage({Key key, @required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Web Page"),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}

class News{

  // Attributes: Meaningful Data which we need to show in UI
  String author;
  String title;
  String description;
  String urlToImage;
  String url;
  String publishedAt;

  News({this.author, this.title, this.description, this.urlToImage, this.url, this.publishedAt});

  // Named Constructor is Using a Constructor within it to create and return an object
  // we must mark it as factory :)
  factory News.fromMap(Map<String, dynamic> map){
    return News(
      author: map['author'],
      title: map['title'],
      description: map['description'],
      urlToImage: map['urlToImage'],
      url: map['url'],
      publishedAt: map['publishedAt'],
    );
  }

}