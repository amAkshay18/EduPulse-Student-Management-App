import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_management_app_using_provider/functions.dart/image_provider.dart';
import 'package:student_management_app_using_provider/functions.dart/student_provider.dart';
import 'package:student_management_app_using_provider/model/model.dart';
import 'package:student_management_app_using_provider/screens/widgets/app_bar_widget.dart';

// ignore: must_be_immutable
class ScreenAddStudent extends StatelessWidget {
  final StudentModel? student;
  ScreenAddStudent({super.key, this.student});
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  // ignore: unused_field
  ImageProvider<Object>? _image;

  // @override
  @override
  Widget build(BuildContext context) {
    // final imageProvider = Provider.of<ImagesProviders>(context, listen: false);
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Add Student',
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  showImage(context);
                },
                child: _buildProfileImage(context),
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _subjectController,
                decoration: const InputDecoration(labelText: 'Subject'),
              ),
              const SizedBox(height: 16),
              TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                onPressed: () => _saveStudent(context),
                child: const Text('Save'),
              ),
              if (student != null)
                ElevatedButton(
                  onPressed: () => _deleteStudent(context),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Delete'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return Consumer<ImagesProviders>(
      builder: (context, value, child) {
        return GestureDetector(
          child: CircleAvatar(
            radius: 50,
            child: SizedBox.fromSize(
              child: ClipOval(
                  child: value.selectedImage != null
                      ? Image.file(
                          value.selectedImage!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.contact_page)
                  //   //   Image.asset(
                  //   // 'student_management_app_using_provider/assets/images/dummy_profile_picture.jpg',
                  //   // fit: BoxFit.cover,
                  // ),
                  ),
            ),
          ),
        );
      },
    );
  }

  void _saveStudent(BuildContext context) async {
    final imageProvider = Provider.of<ImagesProviders>(context, listen: false);
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    final name = _nameController.text;
    final age = int.tryParse(_ageController.text);
    final subject = _subjectController.text;
    final phone = _phoneController.text;
    if (name.isEmpty || age == null || subject.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All fields are required.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final newStudent = StudentModel(
        name: name,
        age: age,
        id: DateTime.now().millisecondsSinceEpoch,
        phone: phone,
        subject: subject,
        image: imageProvider.selectedImage!.path);
    studentProvider.addNewStudent(newStudent);

    Navigator.pop(context);
  }

  void _deleteStudent(BuildContext context) {
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    studentProvider.deleteStudent(student!);
    Navigator.pop(context);
  }

  Future<void> showImage(BuildContext context) async {
    final imagePicker = ImagePicker();
    final imagess = await imagePicker.pickImage(source: ImageSource.gallery);
    if (imagess == null) {
      return;
    }
    // ignore: use_build_context_synchronously
    final imageProvider = Provider.of<ImagesProviders>(context, listen: false);
    imageProvider.setSelectedImage(
      File(imagess.path),
    );
  }
}
