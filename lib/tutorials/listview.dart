import 'package:flutter/material.dart';

Widget getDynamicList(BuildContext context){

  final news = ["CNN", "NDTV", "BCC", "REPUBLIC", "INDIA TV", "AAJ TAK"];
  //final icons = [Icons.perm_device_information, Icons.perm_device_information, ];

  return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.perm_device_information, color: Colors.red,),
          //leading: icons[index]
          title: Text(news[index]),
          trailing: Icon(Icons.keyboard_arrow_right),
        );
      },
  );

}

Widget getDynamicListWithDivider(BuildContext context){

  final news = ["CNN", "NDTV", "BCC", "REPUBLIC", "INDIA TV", "AAJ TAK"];
  //final icons = [Icons.perm_device_information, Icons.perm_device_information, ];

  return ListView.separated(
    itemCount: news.length,
    itemBuilder: (context, index) {
      return ListTile(
        leading: Icon(Icons.perm_device_information, color: Colors.red,),
        //leading: icons[index]
        title: Text(news[index]),
        trailing: Icon(Icons.keyboard_arrow_right),
      );
    },
    separatorBuilder: (context, index) {
      return Divider(
        color: Colors.amber,
      );
    },
  );

}

class NewsListPage extends StatelessWidget{

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