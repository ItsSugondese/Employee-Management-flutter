import 'package:employee_management/screen/deleteEmployee.dart';
import 'package:employee_management/screen/getEmployee.dart';
import 'package:employee_management/screen/registerEmployee.dart';
import 'package:employee_management/screen/updateEmployee.dart';
import 'package:flutter/material.dart';

//contains code that need to be shown in homescreen
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Baic CRUD App"),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GetEmployee())
                      );
                    },
                    child: Text("Get Employees",
                      style: TextStyle(fontSize: 30),

                    ),

                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => UpdateEmployee()));
                    },
                    child: Text("Update Employee",
                        style: TextStyle(fontSize: 30)
                    )
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DeleteEmployee())
                      );
                    },
                    child: Text("Delete Employee",
                        style: TextStyle(fontSize: 30)
                    )
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => RegisterEmpployee())
                      );
                    },
                    child: Text("Register Employees",
                        style: TextStyle(fontSize: 30)
                    )
                ),
              ),
            ],
          )
      ),
    );
  }
}
