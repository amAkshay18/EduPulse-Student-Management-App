import 'package:flutter/material.dart';
import 'package:student_management_app_using_provider/model/model.dart';
import 'package:student_management_app_using_provider/screens/add_screen.dart';
import 'package:student_management_app_using_provider/screens/edit_screen.dart';

void navigateToEditScreen(BuildContext context, StudentModel student, int id,
    int age, String name, String phone, String subject, String img) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => StudentEditScreen(
        age: age,
        name: name,
        phone: phone,
        subject: subject,
        image: img,
        student: student,
        id: id,
      ),
    ),
  );
}

void navigateToAddScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ScreenAddStudent(),
    ),
  );
}
