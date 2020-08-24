import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataTablePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Table"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          PaginatedDataTable(
            header: Text("Students Data"),
            rowsPerPage: 4,
            columns: [
              DataColumn(label: Text("ROLL")),
              DataColumn(label: Text("NAME")),
              DataColumn(label: Text("AGE")),
            ],
            source: StudentDataSource(context),
          )
        ],
      ),
    );
  }
}

// Row Data
class StudentRow{

  int roll;
  String name;
  int age;

  bool selected = false;

  StudentRow(this.roll, this.name, this.age);

}

// Prepare Rows to be displayed in DataTable
class StudentDataSource extends DataTableSource{

  BuildContext context;
  List<StudentRow> rows;
  int selectedCount = 0;

  StudentDataSource(this.context){
    rows = <StudentRow>[
      StudentRow(101, "John", 20),
      StudentRow(201, "Jennie", 22),
      StudentRow(301, "Jim", 24),
      StudentRow(401, "Jack", 21),
      StudentRow(501, "Joe", 18),
      StudentRow(601, "Fionna", 23),
      StudentRow(701, "Sia", 22),
      StudentRow(801, "Kim", 28),
    ];
  }

  @override
  DataRow getRow(int index) { // starts from 0 and goes till the end of rows length
    final row = rows[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(row.roll.toString())),
        DataCell(Text(row.name)),
        DataCell(Text(row.age.toString())),
      ],
      selected: row.selected,
      onSelectChanged: (bool value){
        // Run an Review the code below :)
        row.selected = value;
        notifyListeners();
      }
    );
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => rows.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => selectedCount;
}