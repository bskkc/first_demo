import 'package:flutter/material.dart';
import '../models/student.dart';

import '../validation/student_validator.dart';

class StudentEdit extends StatefulWidget {
  Student selectedStudent;
  StudentEdit(Student selectedStudent) {
    this.selectedStudent = selectedStudent;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StudentAddState(selectedStudent);
  }
}

class _StudentAddState extends State with StudentValidationMixin {
  Student selectedStudent;
  var formKey = GlobalKey<FormState>();
  _StudentAddState(Student selectedStudent) {
    this.selectedStudent = selectedStudent;  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Student Info"),
        ),
        body: Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                buildFirstNameField(),
                buildLastNameField(),
                buildGradeField(),
                buildSubmitButton()
              ],
            ),
          ),
        ));
  }

  Widget buildFirstNameField() {
    return TextFormField(
      initialValue: selectedStudent.firstName,
      decoration: InputDecoration(labelText: "Student Name", hintText: "abc"),
      validator: validateFirstName,
      onSaved: (String value) {
        selectedStudent.firstName = value;
      },
    );
  }

  Widget buildLastNameField() {
    return TextFormField(
      initialValue: selectedStudent.lastName,
      decoration: InputDecoration(labelText: "Student Surname", hintText: "def"),
      validator: validateLastName,
      onSaved: (String value) {
        selectedStudent.lastName = value;
      },
    );
  }

  Widget buildGradeField() {
    return TextFormField(
      initialValue: selectedStudent.grade.toString(),
      decoration: InputDecoration(labelText: "Exam Grade", hintText: "65"),
      validator: validateGrade,
      onSaved: (String value) {
        selectedStudent.grade = int.parse(value);
      },
    );
  }

  Widget buildSubmitButton() {
    return RaisedButton(
      color: Colors.indigoAccent,
      child: Text("Save"),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          saveStudent();
          Navigator.pop(context);
        }
      },
    );
  }

  void saveStudent() {
    print(selectedStudent.firstName);
    print(selectedStudent.lastName);
    print(selectedStudent.grade);
  }
}
