

import 'package:employee_management/model/appBarModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dialogs/updateDialog.dart';
import '../model/employeeModel.dart';
import '../model/networkingModel.dart';

class UpdateEmployee extends StatefulWidget {
  const UpdateEmployee({Key? key}) : super(key: key);

  @override
  State<UpdateEmployee> createState() => _UpdateEmployeeState();
}

class _UpdateEmployeeState extends State<UpdateEmployee> {
  Future<List<EmployeeModel>>? fuck; //for performing GET operation

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fuck = fetchEmployee(); //assigning response from database to the future variable
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: barForApp(context, "Update Employee"),
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
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // updateAlert(context);
                          //Pop up will apprear when clicking edit icon
                          //Update i.e. PUT operation will be performed in this(UpdateDialog) class
                          showDialog(context: context, builder: (BuildContext context){
                            return UpdateDialog(nameToGet: snapshot.data![index].username);
                          });



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




