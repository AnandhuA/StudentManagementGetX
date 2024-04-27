import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:student_database/Db/function.dart';
import 'package:student_database/HomePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding();

  await dataBase();
  // await getStudents();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      // routes: {
      //   "HomePage": (context) => HomePage(),
      //   "AddStudent": (context) => AddStudent(),
      // },
    );
  }
}
