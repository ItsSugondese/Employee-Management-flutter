import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/appBarModel.dart';
import '../model/employeeModel.dart';
import '../model/networkingModel.dart';



class RegisterEmpployee extends StatefulWidget {
  const RegisterEmpployee({Key? key}) : super(key: key);

  @override
  State<RegisterEmpployee> createState() => _RegisterEmpployeeState();
}

class _RegisterEmpployeeState extends State<RegisterEmpployee> {
  final TextEditingController usernameController = TextEditingController(); //for username textfield
  final TextEditingController passwordController = TextEditingController(); //for password textfield

  late EmployeeModel?
  sendData; // responsible for POST operation

  late bool empty = false; //for when textfield is left empty
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: barForApp(context, "Register Employee"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: "Enter employee's username",
                  hintText: "username",
                  errorText: empty? "Username can't be empty" : null,
                ),
              ),
            ),

            SizedBox(height: 20,),

            SizedBox(
              width: 200,
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    labelText: "Enter employee's password",
                    hintText: "password",
                    errorText: empty? "Password can't be empty" : null
                ),
              ),
            ),

            SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () async {

                  List<bool> whatIs=[false, false]; // list contains 2 bool, [0] for if username already exists, [1] for to check if error occurs when POST operation
                  setState(() {

                    //checking if username or password is left empty
    if(usernameController.text.isEmpty || passwordController.text.isEmpty){
    empty = true;
    }else{
    empty = false;
    }
    });

                  //if username and password textfiled isn't empty, performs POST operation
                  if(!empty){
                    sendData = await sendEmployee(
                        usernameController.text, passwordController.text);


                    if(sendData?.username !="" && sendData?.password !=""){
                      whatIs[0] = true;
                      if(sendData != null){
                        whatIs[1] = true;
                      }else{
                        whatIs[1] = false;
                      }
                    }else{
                      whatIs[0] = false;
                      whatIs[1] = false;
                    }

                    buildAlert(context, usernameController.text, passwordController.text, whatIs);

                  }
                },
                child: Text("Submit")),

          ],
        ),

      ),
    );
  }
}

//contains POP up widget responsible for showing whether POST operation was success or a failure
Future buildAlert(BuildContext context , String username, String password, List<bool> whichOne){
  Widget button = TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text("Ok"));

  AlertDialog alertDialog = AlertDialog(
    title: whichOne[0]? whichOne[1]? Text("Added successfully") : Text("Failed To Add") : Text("Can't add"),
    content: whichOne[0]? whichOne[1]? Text("Username is " + username + "\nPassword is " + password) : Text("Error when adding data") : Text("Already exist in database")
    ,

    actions: [
      button,
    ],
  );

  return showDialog(context: context,
      builder: (BuildContext context){
    return alertDialog;
      });
}
