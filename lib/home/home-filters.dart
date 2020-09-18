import 'package:enc_flutter_2020_f1/constants/app-constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeFilters extends StatefulWidget {
  @override
  _HomeFiltersState createState() => _HomeFiltersState();
}

class _HomeFiltersState extends State<HomeFilters> {
  @override
  Widget build(BuildContext context) {
    return
        Container(
          padding: EdgeInsets.all(8.0),
          height: 80,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(8.0),
            children: [
              RaisedButton(
                child: Text(
                  "Vegetarian", style: TextStyle(fontSize: 18.0,),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  side: BorderSide(color: Colors.blueGrey)
                ),
                color: Colors.white,
                onPressed: (){

                },
              ),
              Padding(padding: EdgeInsets.all(6.0),),
              RaisedButton(
                child: Text(
                  "Non Vegetarian", style: TextStyle(fontSize: 18.0,),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    side: BorderSide(color: Colors.blueGrey)
                ),
                color: Colors.white,
                onPressed: (){

                },
              ),
              Padding(padding: EdgeInsets.all(6.0),),
              RaisedButton(
                child: Text(
                  "Trending", style: TextStyle(fontSize: 18.0,),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    side: BorderSide(color: Colors.blueGrey)
                ),
                color: Colors.white,
                onPressed: (){

                },
              ),
              Padding(padding: EdgeInsets.all(6.0),),
              RaisedButton(
                child: Text(
                  "Top5", style: TextStyle(fontSize: 18.0,),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    side: BorderSide(color: Colors.blueGrey)
                ),
                color: Colors.white,
                onPressed: (){

                },
              ),
              Padding(padding: EdgeInsets.all(6.0),),
            ],
          )
    );
  }
}
