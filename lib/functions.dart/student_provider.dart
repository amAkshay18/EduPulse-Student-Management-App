import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_management_app_using_provider/model/model.dart';

class StudentProvider extends ChangeNotifier {
  late Box<StudentModel> _studentsBox;
  List<StudentModel> _studentList = [];
  List<StudentModel> filteredItems = [];

  StudentProvider() {
    initializeHiveBox();
  }

  Future<void> initializeHiveBox() async {
    // await Hive.initFlutter();
    _studentsBox = await Hive.openBox<StudentModel>('students');
    _studentList = _studentsBox.values.toList();
    notifyListeners();
  }

  List<StudentModel> get students => _studentList;

  Future<void> addNewStudent(StudentModel newStudent) async {
    await _studentsBox.add(newStudent);
    log(
      _studentsBox.values.length.toString(),
    );
    _studentList.add(newStudent);
    notifyListeners();
  }

  Future<void> fetchAllStudents() async {
    _studentList.clear();
    _studentList.addAll(_studentsBox.values);
  }

  Future<void> updateStudent(int id, StudentModel updatedStudent) async {
    await _studentsBox.put(id, updatedStudent);
    int studentIndex = _studentList.indexWhere((s) => s.id == id);
    if (studentIndex >= -1) {
      _studentList[studentIndex] = updatedStudent;
    }
    notifyListeners();
  }

  Future<void> deleteStudent(StudentModel student) async {
    await student.delete();
    _studentList.removeWhere((s) => s.key == student.key);
    notifyListeners();
  }

  Future<List<StudentModel>> search(String query) async {
    filteredItems = _studentsBox.values
        .where(
          (student) =>
              student.name.toLowerCase().contains(
                    query.toLowerCase(),
                  ) ||
              student.phone.contains(query),
        )
        .toList();
    notifyListeners();
    return filteredItems;
  }
}
