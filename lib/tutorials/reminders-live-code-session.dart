import 'package:flutter/material.dart';

class RemindersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: FlatButton(
                child: Text(
                  "Edit",
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                hintText: "Search",
                filled: true,
                fillColor: Colors.black12,
                //icon: Icon(Icons.search),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.blueGrey, width: 1.0),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.date_range,
                              color: Colors.blue,
                            ),
                            Text(
                              "0",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20.0),
                            )
                          ],
                        ),
                        Text(
                          "Today",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.blueGrey, width: 1.0),
                    ),
                    child: Column(
                      children: [
                        Wrap(
                          children: [
                            Icon(
                              Icons.timer,
                              color: Colors.amberAccent,
                            ),
                            Text(
                              "1",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20.0),
                            )
                          ],
                        ),
                        Text(
                          "Schedules",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
              height: 60.0,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.blueGrey, width: 1.0),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.folder_open,
                        color: Colors.blueGrey,
                      ),
                      Text(
                        "1",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20.0),
                      )
                    ],
                  ),
                  Text(
                    "All",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
