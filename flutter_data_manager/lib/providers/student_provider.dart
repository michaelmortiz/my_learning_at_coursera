import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_data_manager/models/student_model.dart' as student_model;


class StudentProvider with ChangeNotifier {
  final LocalStorage storage;
  List<student_model.Student> _students = [];

  StudentProvider({required this.storage}) {
    // TODO: add localstorage
    _loadStudentsFromStorage();
  }

  List<student_model.Student> get students => _students;

  void _loadStudentsFromStorage() async {
    var data = storage.getItem('students');
    if (data != null) {
      _students = List<student_model.Student>.from((jsonDecode(data) as List)
          .map((item) => student_model.Student.fromMap(item as Map<String, dynamic>)));
      notifyListeners();
    }
  }

  void addStudent(student_model.Student student) {
    _students.add(student);
    _saveToStorage();
    notifyListeners();
  }

  void _saveToStorage() {
    storage.setItem('students',
        jsonEncode(_students.map((student) => student.toMap()).toList()));
  }

  void updateStudent(student_model.Student student) {
    var index = _students.indexWhere((element) => element.id == student.id);
    if (index != -1) {
      _students[index] = student;
      _saveToStorage();
      notifyListeners();
    }
  }

  void removeStudent(int id) {
    _students.removeWhere((student) => student.id == id);
    notifyListeners();
  }

  void deleteStudent(int id) {
    _students.removeWhere((element) => element.id == id);
    _saveToStorage();
    notifyListeners();
  }
}
