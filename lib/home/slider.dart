import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

// we can create a separate collection called advertisements from where we can fetch these documents having link to advertisement with url and title and may be other details

// Network Links to Images
final List<String> imageList = [
  'https://firebasestorage.googleapis.com/v0/b/nimble-perigee-501.appspot.com/o/dishes-pics%2Fbiryani.png?alt=media&token=aea7d6c3-8119-4e73-bbad-e774870d6a67',
  'https://firebasestorage.googleapis.com/v0/b/nimble-perigee-501.appspot.com/o/dishes-pics%2Fpval5.png?alt=media&token=0e40591b-235e-418a-85e8-1ecf1b0afd3a',
  'https://firebasestorage.googleapis.com/v0/b/nimble-perigee-501.appspot.com/o/dishes-pics%2Fchole-bhature.png?alt=media&token=a8a99841-b298-4992-92db-0efe597c8cfd',
  'https://firebasestorage.googleapis.com/v0/b/nimble-perigee-501.appspot.com/o/dishes-pics%2Fpval7.png?alt=media&token=cffe87a0-f55f-47e9-9cec-54262b2379bf'
];

// Title for Images
final List<String> imageTitle = [
  'Delightful Dish',
  'Invest In Property',
  'North Indian Delight',
  'Property Valuation'
];


final List<Widget> imageSliders = imageList.map((item) => Container(
  child: Container(
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.network(item, fit: BoxFit.cover, width: 1000.0),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  '${imageTitle[imageList.indexOf(item)]}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          ],
        )
    ),
  ),
)).toList();


class HomePageSlider extends StatefulWidget {
  @override
  _HomePageSliderState createState() => _HomePageSliderState();
}

class _HomePageSliderState extends State<HomePageSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            ),
            items: imageSliders,
          ),
        ],)
    );
  }
}
