import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_app_using_provider/view/screens/details_screen.dart';
import 'package:student_management_app_using_provider/view/screens/search_screen.dart';
import 'package:student_management_app_using_provider/view/widgets/app_bar_widget.dart';
import 'package:student_management_app_using_provider/view_model/functions.dart/functions.dart';
import 'package:student_management_app_using_provider/view_model/providers/image_provider.dart';
import 'package:student_management_app_using_provider/view_model/providers/student_provider.dart';

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final imageProvider = Provider.of<ImagesProviders>(context, listen: false);
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    studentProvider.fetchAllStudents();
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Home',
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenSearch(),
                ),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Consumer<StudentProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.students.length,
            itemBuilder: (context, index) {
              final student = value.students[index];
              File img = File(student.image);
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ScreenDetails(
                          name: student.name,
                          age: student.age.toString(),
                          subject: student.subject,
                          phone: student.phone,
                          image: student.image,
                        );
                      },
                    ),
                  );
                },
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    child: SizedBox.fromSize(
                      child: ClipOval(
                        // ignore: unnecessary_null_comparison
                        child: student.image != null
                            ? Image.file(
                                img,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/default_profile.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  title: Text(
                    student.name,
                    style: const TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(
                    'Age: ${student.age}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          color: Colors.purple,
                          icon: const Icon(Icons.edit),
                          onPressed: () => navigateToEditScreen(
                              context,
                              student,
                              student.key,
                              student.age,
                              student.name,
                              student.phone,
                              student.subject,
                              student.image),
                        ),
                        IconButton(
                          color: Colors.purple,
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Confirm Delete'),
                                  content: const Text(
                                      'Are you sure you want to delete this student?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        value.deleteStudent(student);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () => navigateToAddScreen(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
