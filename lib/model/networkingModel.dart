import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'employeeModel.dart';

//Method that performs GET operation
Future<List<EmployeeModel>> fetchEmployee() async{
  final response = await http.get(Uri.parse("http://localhost:9192/get"));

  if(response.statusCode == 200){
    return compute(parseEmployees,  response.body);
  }else{
     throw Exception("Not found");
  }
}

//Method that performs POST operation
Future<EmployeeModel?> sendEmployee(String username, String password) async{

  //checking whether the username that we are posting already exist in database or not
  final check = await http.get(Uri.parse("http://localhost:9192/get/$username"));
  if(check.statusCode != 200) {
    //POST operation starts from here
    final response = await http.post(Uri.parse("http://localhost:9192/add"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password
      }),
    );

    if (response.statusCode != 201) {
      return EmployeeModel.fromJson(jsonDecode(response.body));
    } else {
       return null;
    }
  }else{

    //sending empty string just so we can use condition
    String jsun = '{"username": "", "password": ""}';
     return EmployeeModel.fromJson(jsonDecode(jsun));
  }
}

//Method that performs PUT operation
Future<EmployeeModel?> updateEmployee(String username, String password, String oldUsername) async{

  //checking whether the username that we are updating exists in databse or not
  final check = await http.get(Uri.parse("http://localhost:9192/get/$username"));
  if(check.statusCode != 200) {
    //PUT operation stats from here
    final response = await http.put(
      Uri.parse("http://localhost:9192/update/$oldUsername"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password
      },

      ),
    );

    if (response.statusCode == 201) {
      return EmployeeModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }else{
    //sending empty string just so we can use condition
    String jsun = '{"username": "", "password": ""}';
    return EmployeeModel.fromJson(jsonDecode(jsun));
  }
}

//Method that performs DELETE operation
Future<EmployeeModel> deleteEmployee(String name) async {
  final http.Response response = await http.delete(
    Uri.parse('http://localhost:9192/delete/$name'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return EmployeeModel.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a "200 OK response",
    // then throw an exception.
    throw Exception('Failed to delete employee.');
  }
}