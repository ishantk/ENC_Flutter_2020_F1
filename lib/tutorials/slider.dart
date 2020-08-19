import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget{
  createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget>{

  double sliderValue = 5;

  @override
  Widget build(BuildContext context) {

    return Slider(
      min: 1,
      max: 10,
      divisions: 5,
      value: sliderValue,
      label: "Value: ${sliderValue.round()}",
      onChanged: (double value) {
        setState(() {
          sliderValue = value;
        });
      },
    );

  }
}