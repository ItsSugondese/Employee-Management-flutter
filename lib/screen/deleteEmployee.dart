import 'package:employee_management/dialogs/deleteDialog.dart';
import 'package:employee_management/model/appBarModel.dart';
import "package:flutter/material.dart";

import '../model/employeeModel.dart';
import '../model/networkingModel.dart';

class DeleteEmployee extends StatefulWidget {
  const DeleteEmployee({Key? key}) : super(key: key);

  @override
  State<DeleteEmployee> createState() => _DeleteEmployeeState();
}

class _DeleteEmployeeState extends State<DeleteEmployee> {
  Future<List<EmployeeModel>>? fuck; //responsible for running GET operation
  bool? isIt; //will be initialized when dialog pop up ends

  Future<EmployeeModel>? deleteFuture; //responsible for running DELETE operation
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fuck = fetchEmployee(); //inserting response from database to the future variable
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: barForApp(context, "Delete Employee"),
      body: FutureBuilder<List<EmployeeModel>>(
          future: fuck,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return Center(
                child: ListView.builder(
                    padding: EdgeInsets.all(20),
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index){
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                // padding: EdgeInsets.all(7),
                                height: 30,
                                width: 100,
                                child: Center(
                                    child: Text(snapshot.data![index].username)),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.red,
                                    ),
                                    borderRadius: BorderRadius.circular(9)
                                ),
                              ),
                              SizedBox(width: 8,),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () async {
                                  // updateAlert(context);
                                  String temp = snapshot.data![index].username;
                                  await showDialog(context: context, builder: (BuildContext context){
                                    return DeleteDialog(name: snapshot.data![index].username);
                                  }).then((value) => isIt = value);                                // assigning value send by delete dialog class during pop up to init variable

                                  if(isIt == true){
                                    CustomWidgets.buildErrorSnackbar(context, "Successfully deleted $temp"); // using the static method that return scaffold messanger to disply
                                                                                                            // which item was deleted

                                    //refresing this class
                                    Navigator.pushAndRemoveUntil(context,
                                        MaterialPageRoute(builder: (context) => DeleteEmployee()),
                                            (route) => false);
                                  }


                                },
                                splashRadius: 20,
                              ),
                            ],
                          ),
                          SizedBox(height: 8,),


                        ],
                      );
                    }
                ),
              );
            }else if(snapshot.hasError){
              return Text("${snapshot.error}");
            }else{
              return CircularProgressIndicator();
            }
          }
      ),
    );
  }

}

class CustomWidgets {
  CustomWidgets._();

  //contains scaffold messanger
  static buildErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text("$message"),
      ),
    );
  }
}



