import 'dart:convert';

import 'package:flutter/foundation.dart';


//this whole dart file is responsible getting and sending the value to the server in JSON format

List<EmployeeModel> parseEmployees(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<EmployeeModel>((json) => EmployeeModel.fromJson(json)).toList();
}

class EmployeeModel{
  String username;
  String password;

  EmployeeModel({required this.username,required this.password});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
        username: json['username'],
        password : json['password']);
  }
}