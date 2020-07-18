import 'package:db_demo/models/student.dart';
import 'package:db_demo/screens/add_student.dart';
import 'package:db_demo/screens/edit_student.dart';
import 'package:db_demo/services/student_operations.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Student> studentList = [];

  Future<void> getData() async {
    List<Student> s = await StudentOperations.instance.getAllStudents();

    setState(() {
      studentList = s;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student App'),
      ),
      body: studentList.length == 0
          ? Center(
              child: Text('No Student'),
            )
          : ListView.builder(
              itemCount: studentList.length,
              itemBuilder: (BuildContext context, int index) {
                Student stud = studentList[index];
                return ListTile(
                  leading: CircleAvatar(child: Text(stud.name[0])),
                  title: Text(stud.name),
                  subtitle: Text(stud.branch),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      StudentOperations.instance.deleteStudent(stud);
                      setState(() {
                        getData();
                      });
                    },
                  ),
                  onTap: () async {
                    // jump to edit student
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => EditStudent(
                          student: stud,
                        ),
                      ),
                    );

                    setState(() {
                      getData();
                    });
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AddStudent(),
            ),
          );

          setState(() {
            getData();
          });
        },
      ),
    );
  }
}
