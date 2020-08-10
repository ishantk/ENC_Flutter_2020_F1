import 'package:flutter/material.dart';

//Container, BoxDecoration, Expanded, Column and Row

class ContainerWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Container"),
      ),
      body: Center(
        //child: getImagesColumnWise(context),
        child: getImagesRowWise(context),
      )
    );
  }
}

Widget getImagesColumnWise(BuildContext context){

  Size size = MediaQuery.of(context).size;

  return SingleChildScrollView( // anything in this SingleChildScrollView becomes scrollable
    child: Container( // Must ensure width and height
      width: size.width,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.lightGreenAccent
      ),
      child: Column(
        children: [
          getDecoratedImage(context, "steve.png"),
          getDecoratedImage(context, "bill.png"),
          getDecoratedImage(context, "larry.png"),
          getDecoratedImage(context, "steve.png"),
          getDecoratedImage(context, "bill.png"),
          getDecoratedImage(context, "larry.png"),
        ],
      ),
    )
  );
}

Widget getImagesRowWise(BuildContext context){
  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
        color: Colors.lightGreenAccent
    ),
    child: Row(
      children: [
        getDecoratedImage(context, "steve.png"),
        getDecoratedImage(context, "bill.png"),
        getDecoratedImage(context, "larry.png"),
      ],
    ),
  );
}


Widget getDecoratedImage(BuildContext context, String imageName){

  Size size = MediaQuery.of(context).size;

  return Expanded(
    child: Container(
      width: size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          border: Border.all(width: 3, color: Colors.black)
      ),
      margin: EdgeInsets.all(4.0),
      child: Image.asset("assets/$imageName"),
    )
  );
}

