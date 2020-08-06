import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// MODEL
class News{

  String title;
  String url;

  News({this.title, this.url});

}

// CONTOROLLER
Widget getDynamicListWithDivider(BuildContext context){

  // List of News Objects :)
  final news = [
    News(title: "NDTV", url: "https://www.ndtv.com/"),
    News(title: "AAJ TAK", url: "https://aajtak.intoday.in/"),
    News(title: "CNN", url: "https://edition.cnn.com/"),
    News(title: "REPUBLIC", url: "https://www.republicworld.com/"),
    News(title: "CNBC", url: "https://www.cnbc.com/"),
  ];


  return ListView.separated(
    itemCount: news.length,
    itemBuilder: (context, index) {
      return ListTile(
        leading: Icon(Icons.perm_device_information, color: Colors.red,),
        //leading: icons[index]
        title: Text(news[index].title, style: TextStyle(fontSize: 18.0, color: Colors.black),),
        subtitle: Text(news[index].url, style: TextStyle(fontSize: 14.0, color: Colors.amber),),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          MaterialPageRoute route = MaterialPageRoute(builder: (context) => NewsPage(url: news[index].url));
          Navigator.push(context, route);
        },
      );
    },
    separatorBuilder: (context, index) {
      return Divider();
    },
  );

}

// VIEW
class NewsList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("News List"),
        ),
        body: getDynamicListWithDivider(context) //getDynamicList(context),
    );
  }
}

class NewsPage extends StatelessWidget{

  String url;

  NewsPage({Key key, @required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("News List"),
        ),
        body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: url,
        )
    );
  }
}