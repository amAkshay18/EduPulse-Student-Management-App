import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_management_app_using_provider/screens/widgets/app_bar_widget.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatelessWidget {
  String name;
  String age;
  String subject;
  String phone;
  String image;
  DetailsScreen(
      {super.key,
      required this.name,
      required this.age,
      required this.subject,
      required this.phone,
      required this.image});

  @override
  Widget build(BuildContext context) {
    File img = File(image);
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Details',
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: SizedBox.fromSize(
                child: ClipOval(
                  // ignore: unnecessary_null_comparison
                  child: image != null
                      ? Image.file(
                          img,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'student_management_app_using_provider/assets/dummy_profile_picture.jpeg',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(name),
            const SizedBox(
              height: 25,
            ),
            Text(age),
            const SizedBox(
              height: 25,
            ),
            Text(subject),
            const SizedBox(
              height: 25,
            ),
            Text(phone),
          ],
        ),
      ),
    );
  }
}
