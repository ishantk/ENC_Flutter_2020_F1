import 'package:flutter/material.dart';

/*
class ChipWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: CircleAvatar(
        backgroundColor: Colors.blueGrey,
        child: Text("JW"),
      ),
      label: Text("John Watson"),
    );
  }
}
*/

class ChipsWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // Wrap places multiple widgets evenly with some spacing either in main axis or cross axis
    return Wrap( //
      spacing: 8.0, // spacing between adjacent chips
      children: [
        Chip(
          avatar: CircleAvatar(
            backgroundColor: Colors.blueGrey,
            child: Text("VG"),
          ),
          label: Text("Vegeterian"),
        ),
        Chip(
          avatar: CircleAvatar(
            backgroundColor: Colors.blueGrey,
            child: Text("SI"),
          ),
          label: Text("South Indian"),
        ),
        Chip(
          avatar: CircleAvatar(
            backgroundColor: Colors.blueGrey,
            child: Text("CO"),
          ),
          label: Text("Continental"),
        )
      ],
    );
  }
}

class ChoiceChipWidget extends StatefulWidget{
  createState() => _ChoiceChipWidgetState();
}

class _ChoiceChipWidgetState extends State<ChoiceChipWidget>{

  int idx = 1;

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 8.0,
        children: List<Widget>.generate(3, (int index){
          return ChoiceChip(
            label: Text("Chip ${index}"),
            selected: idx == index,
            onSelected: (bool value) {
              setState(() {
                idx = value ? index : null;
              });
            },
          );
        })
    );
  }
}
//
//
//        [
//          ChoiceChip(
//            label: Text("Chip 1"),
//            selected: selections[idx],
//            onSelected: (bool value) {
//              setState(() {
//                idx = 0;
//                selections[0] = true;
//                selections[1] = false;
//                selections[2] = false;
//              });
//            },
//          ),
//          ChoiceChip(
//            label: Text("Chip 2"),
//            selected: selections[idx],
//            onSelected: (bool value) {
//              setState(() {
//                idx = 1;
//                selections[0] = false;
//                selections[1] = true;
//                selections[2] = false;
//              });
//            },
//          ),
//          ChoiceChip(
//            label: Text("Chip 3"),
//            selected: selections[idx],
//            onSelected: (bool value) {
//              setState(() {
//                idx = 2;
//                selections[0] = false;
//                selections[1] = false;
//                selections[2] = true;
//              });
//            },
//          )
//        ],
//      );
