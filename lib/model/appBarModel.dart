import 'package:employee_management/screen/homeScreen.dart';
import 'package:flutter/material.dart';


//widget to use as AppBar in Scaffold
AppBar barForApp(BuildContext context, String text){
  return AppBar(
    title: Text("$text"),
    centerTitle: true,
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: (){
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false);
      },
    ),
  );
}