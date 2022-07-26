import 'package:flutter/material.dart';
import 'package:kurulum_demo/screens/student_add.dart';
import 'package:kurulum_demo/screens/student_edit.dart';

import 'models/student.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String message = "Student Tracking System";

  Student selectedStudent=Student.withId(0,"","",0);

  List<Student> students = [
    Student.withId(1,"name", "surname", 70),
    Student.withId(2,"name1", "surname1", 20),
    Student.withId(3,"name2", "surname2", 45)
  ];

  //var ogrenciler = ["Basak", "Basak1", "Basak2", "Basak3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(message),
      ),
      body: buildBody(context),
    );
  }


  void showMessage(BuildContext context, String message) {
    var alert = AlertDialog(
      title: Text("Result"),
      content: Text(message),
    );

    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://www.manzara.gen.tr/w1/manzara-resimleri-167.jpg"),
                    ),
                    title: Text(students[index].firstName +
                        " " +
                        students[index].lastName),
                    subtitle: Text("Grade from the exam : " +
                        students[index].grade.toString() +
                        " [" +
                        students[index].getStatus +
                        "]"),
                    trailing: buildStatusIcon(students[index].grade),
                    onTap: () {
                      setState(() {
                        selectedStudent = students[index];
                      });
                      print(selectedStudent.firstName);
                    },
                  );
                })),
        Text("Selected Student : " + selectedStudent.firstName),
        Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: RaisedButton(
                color: Colors.greenAccent,
                child: Row(
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 2.0,),
                    Text("New Student"),
                  ],
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentAdd(students)));
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                color: Colors.orangeAccent,
                child: Row(
                  children: [
                    Icon(Icons.update),
                    SizedBox(width: 2.0,),
                    Text("Edit"),
                  ],
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentEdit(selectedStudent)));
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                color: Colors.redAccent,
                child: Row(
                  children: [
                    Icon(Icons.delete),
                    SizedBox(width: 2.0,),
                    Text("Delete"),
                  ],
                ),
                onPressed: () {
                  setState((){
                    students.remove(selectedStudent);
                  });

                  var message = "Deleted : " + selectedStudent.firstName;
                  showMessage(context, message);
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget buildStatusIcon(int grade) {
    if (grade >= 50) {
      return Icon(Icons.done);
    } else if (grade >= 40) {
      return Icon(Icons.album);
    } else {
      return Icon(Icons.clear);
    }
  }
}
