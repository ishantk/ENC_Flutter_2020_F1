import 'package:flutter/material.dart';

class HeroPageOne extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HeroPageOne"),
      ),
      body: GestureDetector(
        child: Hero(
          tag: "tag",
          child: Image.network("https://firebasestorage.googleapis.com/v0/b/auriai-165008.appspot.com/o/r1.jpeg?alt=media&token=756003de-ef0f-402d-92e0-512c82f66bf9"),
        ),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HeroPageTwo(),));
        },
      ),
    );
  }
}


class HeroPageTwo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HeroPageTwo"),
      ),
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: "tag",
            child: Image.network("https://firebasestorage.googleapis.com/v0/b/auriai-165008.appspot.com/o/r1.jpeg?alt=media&token=756003de-ef0f-402d-92e0-512c82f66bf9"),
          ),
        ),
        onTap: () {
         Navigator.pop(context);
        },
      ),
    );
  }
}

// In Page One take the image size as small
// In Page Two take the image size in full :)