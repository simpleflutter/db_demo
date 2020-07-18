import 'package:db_demo/models/student.dart';
import 'package:db_demo/services/student_operations.dart';
import 'package:flutter/material.dart';

class EditStudent extends StatelessWidget {
  final Student student;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController branchController = TextEditingController();

  EditStudent({this.student});

  @override
  Widget build(BuildContext context) {
    // set values to controller
    nameController.text = student.name;
    branchController.text = student.branch;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Stdudent'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'Name',
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: branchController,
            decoration: InputDecoration(
              hintText: 'Branch',
            ),
          ),
          SizedBox(height: 16),
          RaisedButton(
            child: Text('Edit Student'),
            onPressed: () async {
              String name = nameController.text;
              String branch = branchController.text;

              Student s = Student(id: student.id, name: name, branch: branch);
              await StudentOperations.instance.editStudent(s);
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
