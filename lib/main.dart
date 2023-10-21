import 'package:employee_management/screen/deleteEmployee.dart';
import 'package:employee_management/screen/getEmployee.dart';
import 'package:employee_management/screen/homeScreen.dart';
import 'package:employee_management/screen/registerEmployee.dart';
import 'package:employee_management/screen/updateEmployee.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: HomeScreen(),
    );
  }
}

