import 'package:enc_flutter_2020_f1/constants/app-constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeFilters extends StatefulWidget {

  Function(String) update;

  HomeFilters({Key key, this.update}): super(key: key);

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
                  Constants.TAG1, style: TextStyle(fontSize: 18.0,),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  side: BorderSide(color: Colors.blueGrey)
                ),
                color: Colors.white,
                onPressed: (){
                  widget.update(Constants.TAG1);
                },
              ),
              Padding(padding: EdgeInsets.all(6.0),),
              RaisedButton(
                child: Text(
                  Constants.TAG2, style: TextStyle(fontSize: 18.0,),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    side: BorderSide(color: Colors.blueGrey)
                ),
                color: Colors.white,
                onPressed: (){
                  widget.update(Constants.TAG2);
                },
              ),
              Padding(padding: EdgeInsets.all(6.0),),
              RaisedButton(
                child: Text(
                  Constants.TAG3, style: TextStyle(fontSize: 18.0,),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    side: BorderSide(color: Colors.blueGrey)
                ),
                color: Colors.white,
                onPressed: (){
                  widget.update(Constants.TAG3);
                },
              ),
              Padding(padding: EdgeInsets.all(6.0),),
            ],
          )
    );
  }
}
