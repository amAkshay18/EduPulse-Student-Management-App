import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:student_management_app_using_provider/functions.dart/image_provider.dart';
import 'package:student_management_app_using_provider/functions.dart/student_provider.dart';
import 'package:student_management_app_using_provider/screens/home_screen.dart';
import 'model/model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(
    StudentModelAdapter(),
  );
  await StudentProvider().initializeHiveBox();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => StudentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ImagesProviders(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Student Management App',
        home: StudentListScreen(),
      ),
    );
  }
}
