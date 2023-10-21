import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/appBarModel.dart';
import '../model/employeeModel.dart';
import '../model/networkingModel.dart';



class GetEmployee extends StatefulWidget {
  const GetEmployee({Key? key}) : super(key: key);

  @override
  State<GetEmployee> createState() => _GetEmployeeState();
}

class _GetEmployeeState extends State<GetEmployee> {
  Future<List<EmployeeModel>>? fuck; //responsible for running GET operation

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fuck = fetchEmployee(); //inserting response from database to the future variable

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: barForApp(context, "Get Employee"),
      body: FutureBuilder<List<EmployeeModel>>(
        future: fuck,
          builder: (context, snapshot){
          if(snapshot.hasData){
            return Center(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index){
                   return Column(
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
                       SizedBox(height: 8,)
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
