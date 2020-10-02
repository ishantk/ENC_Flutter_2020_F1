import 'package:enc_flutter_2020_f1/home/home-filters.dart';
import 'package:enc_flutter_2020_f1/home/slider.dart';
import 'package:enc_flutter_2020_f1/restaurant/restaurant-list.dart';
import 'package:flutter/material.dart';

class RestaurantsHomePage extends StatefulWidget {

  @override
  _RestaurantsHomePageState createState() => _RestaurantsHomePageState();
}

class _RestaurantsHomePageState extends State<RestaurantsHomePage> {

  String filter = "";

  implementFiltersAndRefreshUI(String data){
    setState((){
      filter = data;
    });
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(16.0),
      children: [
        Container(
          child: HomeFilters(update: implementFiltersAndRefreshUI,),
          height: 80.0,
        ),
        Padding(padding: EdgeInsets.all(16.0),),
        HomePageSlider(),
        Padding(padding: EdgeInsets.all(16.0),),
        RestaurantPage(filter: filter,)
      ],
    );
  }
}
