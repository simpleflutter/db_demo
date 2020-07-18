import 'package:sqflite/sqflite.dart';
import 'package:db_demo/models/student.dart';
import 'databaese_helper.dart';
import 'dart:core';

class StudentOperations {
  //private constructor
  StudentOperations._();

  static final StudentOperations instance = StudentOperations._();

  Future<int> addStudent(Student student) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert('students', student.toMap());
  }

  Future<int> deleteStudent(Student student) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.delete('students', where: 'id=?', whereArgs: [student.id]);
  }

  Future<int> editStudent(Student student) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.update('students', student.toMap(),
        where: 'id=?', whereArgs: [student.id]);
  }

  Future<List<Student>> getAllStudents() async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> maps = await db.query('students');

    List<Student> students = [];

    for (int i = 0; i < maps.length; i++) {
      students.add(Student.fromMap(maps[i]));
    }

    return students;
  }
}
