import 'package:flutter/material.dart';

// MODEL
class CovidCase {
  // Attributes
  int active;
  int confirmed;
  int deaths;
  String state;
  String notes;

  CovidCase({this.active, this.confirmed, this.deaths, this.state, this.notes});
}

Widget getDynamicListWithDividerForCovidCases(BuildContext context) {
  /*
  CovidCase case1 = CovidCase(active: 3412441, confirmed: 31241, deaths: 113, state: "Maharashtra", notes: "307 cases are marked as non-covid deaths in MH bulletin");
  CovidCase case2 = CovidCase(active: 2112441, confirmed: 1241, deaths: 223, state: "Tamil Nadu", notes: "444 backdated deceased entries added to Chennai");
  CovidCase case3 = CovidCase(active: 12441, confirmed: 4241, deaths: 313, state: "Delhi", notes: " Value for the total tests conducted has been reduced by 97008");
  CovidCase case4 = CovidCase(active: 51243, confirmed: 43141, deaths: 323, state: "Karnataka", notes: "9 cases are classified as non-covid related deaths in KA bulletin");
  CovidCase case5 = CovidCase(active: 71244, confirmed: 312, deaths: 233, state: "Andhra Pradesh", notes: "Total includes patients from other states and a new category");

  final cases = [case1, case2, case3, case4, case5];*/

  final cases = <CovidCase>[
    CovidCase(
        active: 3412441,
        confirmed: 31241,
        deaths: 113,
        state: "Maharashtra",
        notes: "307 cases are marked as non-covid deaths in MH bulletin"),
    CovidCase(
        active: 2112441,
        confirmed: 1241,
        deaths: 223,
        state: "Tamil Nadu",
        notes: "444 backdated deceased entries added to Chennai"),
    CovidCase(
        active: 12441,
        confirmed: 4241,
        deaths: 313,
        state: "Delhi",
        notes:
            " Value for the total tests conducted has been reduced by 97008"),
    CovidCase(
        active: 51243,
        confirmed: 43141,
        deaths: 323,
        state: "Karnataka",
        notes:
            "9 cases are classified as non-covid related deaths in KA bulletin"),
    CovidCase(
        active: 71244,
        confirmed: 312,
        deaths: 233,
        state: "Andhra Pradesh",
        notes: "Total includes patients from other states and a new category")
  ];

  return ListView.separated(
    itemCount: cases.length,
    itemBuilder: (context, index) {
      return ListTile(
        leading: Icon(
          Icons.healing,
          color: Colors.red,
        ),
        //leading: icons[index]
        title: Text(
          cases[index].state,
          style: TextStyle(color: Colors.black, fontSize: 24.0),
        ),
        subtitle: Text(
          "Confirmed: ${cases[index].confirmed}\nActive: ${cases[index].active}",
          style: TextStyle(color: Colors.orange, fontSize: 16.0),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CovidCaseDetailsPage(
                  covidCase: cases[index],
                ),
              ));
        },
      );
    },
    separatorBuilder: (context, index) {
      return Divider(
        color: Colors.amber,
      );
    },
  );
}

class CovidCaseListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Covid Cases"),
        ),
        body: getDynamicListWithDividerForCovidCases(context));
  }
}

class CovidCaseDetailsPage extends StatelessWidget {
  CovidCase covidCase;

  CovidCaseDetailsPage({Key key, @required this.covidCase}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cases For ${covidCase.state}"),
      ),
      body: Center(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/virus.png'),
                SizedBox(
                  height: 2.0,
                ),
                Text(
                  covidCase.state,
                  style: TextStyle(color: Colors.orange, fontSize: 24.0),
                ),
                SizedBox(
                  height: 2.0,
                ),
                Text(
                  "Active: ${covidCase.active}",
                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
                ),
                SizedBox(
                  height: 2.0,
                ),
                Text(
                  "Confirmed: ${covidCase.confirmed}",
                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
                ),
                SizedBox(
                  height: 2.0,
                ),
                Text(
                  "Deaths: ${covidCase.deaths}",
                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
                ),
                SizedBox(
                  height: 2.0,
                ),
                Text(
                  "Notes\n${covidCase.notes}",
                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
                ),
              ],
            )),
      ),
    );
  }
}
