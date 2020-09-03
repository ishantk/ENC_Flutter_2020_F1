import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enc_flutter_2020_f1/constants/app-constants.dart';
import 'package:flutter/material.dart';

class Student{

  int roll;
  String name;
  int age;
  List<Subject> subjects; // Has-A Relationship | 1 to many :)

  Student();
  Student.init({this.roll, this.name, this.age, this.subjects});

  List<Map<String, dynamic>> subjectsToMap(){
    var subList = <Map<String, dynamic>>[];

    for(int i=0;i<subjects.length;i++){
      subList.add(subjects[i].toMap());
    }

    // for each loop implementation on list
    // subjects.forEach((subject) {subList.add(subject.toMap()) });

    // Explore the syntax below :) and convert the subject list as list of hashmaps
    //subjects.map((e) => null).toList()
    return subList;
  }

  Map<String, dynamic> toMap(){
    return {
      "roll": roll,
      "name": name,
      "age": age,
      "subjects": subjectsToMap()
    };
  }
}

class Subject{

  String name;
  int marks;

  Subject();
  Subject.init({this.name, this.marks});

  /*
  @factory
  Subject.toObject(Map<String, dynamic> map){
    Subject.init(name: map['name'], marks: map['marks']);
  }*/

  Map<String, dynamic> toMap(){
    return {
      "name": name,
      "marks": marks
    };
  }

}

insertStudent(){

  Subject subject1 = Subject.init(name:"Physics", marks: 60);
  Subject subject2 = Subject.init(name:"Maths", marks: 80);
  Subject subject3 = Subject.init(name:"Hindi", marks: 75);

  Student student = Student.init(roll: 301, name:"Dave", age: 20, subjects: [subject1, subject2, subject3]);
  // Firebase Firestore expects us to store data has Map :)
  var studentMap = student.toMap();

  // Obtain Reference to the DataBase
  FirebaseFirestore db = FirebaseFirestore.instance;

  // Document ID will be generated automatically
  //db.collection(Constants.STUDENT_COLLECTION).add(studentMap);

  // // Document ID will be maintained by us as per our customized requirement
  //db.collection(Constants.STUDENT_COLLECTION).doc(studentMap['roll']).set(studentMap);
  //db.collection(Constants.STUDENT_COLLECTION).doc(student.roll.toString()).set(studentMap);
  db.collection(Constants.STUDENT_COLLECTION)
      .doc(student.roll.toString())
      .set(studentMap)
      .then((value){
        print("Student Object Inserted :)");
      });
}

// Must have document id :)
deleteStudent(){
  // Obtain Reference to the DataBase
  FirebaseFirestore db = FirebaseFirestore.instance;
  db.collection(Constants.STUDENT_COLLECTION).doc('201').delete().then((value){
      // Do whatever after we delete the document
    print("Student Object Deleted :)");
  });

}

// Must have document id :)
updateStudent(){

  Subject subject1 = Subject.init(name:"Physics", marks: 70);
  Subject subject2 = Subject.init(name:"Maths", marks: 90);
  Subject subject3 = Subject.init(name:"Hindi", marks: 67);

  Student student = Student.init(roll: 201, name:"Fionna Flynn", age: 21, subjects: [subject1, subject2, subject3]);
  // Firebase Firestore expects us to store data has Map :)
  var studentMap = student.toMap();

  // Obtain Reference to the DataBase
  FirebaseFirestore db = FirebaseFirestore.instance;


  db.collection(Constants.STUDENT_COLLECTION)
      .doc(student.roll.toString())
      .set(studentMap) // can also be used to update. but will overwrite the document entirely
      .then((value){
    print("Student Object Inserted :)");
  });

  // if document is not existing it will thor error
  /*db.collection(Constants.STUDENT_COLLECTION).doc('201').update(studentMap)
  .then((value){
    print("Student Object Updated :)");
  });*/ // It adds a new field in case it was missing in previous approach

}

fetchStudents(){
  // Obtain Reference to the DataBase
  FirebaseFirestore db = FirebaseFirestore.instance;
  db.collection(Constants.STUDENT_COLLECTION).get().then((QuerySnapshot snapshot){
    List<QueryDocumentSnapshot> docs = snapshot.docs;
    docs.forEach((queryDocSnapshot) {
      print(queryDocSnapshot.data().toString()); // Firebase will return data as Maps :)
    });
  });
}

class FirestoreDBOperationsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("Firebase DB Operations"),
       ),
      body: Center(
        child: Expanded(
          child: Column(
            children: [
              RaisedButton(
                child: Text("INSERT STUDENT"),
                onPressed: () async {
                  insertStudent();
                },
              ),
              RaisedButton(
                child: Text("DELETE STUDENT"),
                onPressed: () async {
                  deleteStudent();
                },
              ),
              RaisedButton(
                child: Text("UPDATE STUDENT"),
                onPressed: () async {
                  updateStudent();
                },
              ),
              RaisedButton(
                child: Text("FETCH STUDENTS"),
                onPressed: () async {
                  fetchStudents();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}