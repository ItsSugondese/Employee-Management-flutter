import 'package:employee_management/model/employeeModel.dart';
import 'package:employee_management/model/networkingModel.dart';
import "package:flutter/material.dart";

import '../screen/updateEmployee.dart';

//class that shows pop up when clicked on Edit icon
class UpdateDialog extends StatefulWidget {

  final String nameToGet; //item that is being updated

  const UpdateDialog ({Key? key, required this.nameToGet}): super(key: key);

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}



class _UpdateDialogState extends State<UpdateDialog> {

late bool check; //for update and cancel button

  late bool okCheck; //for ok button when no problem arises in server

late bool empty = false; //for textfield error

late List<bool> ifError = [false, false]; //for rename, cancel and ok button, when error occur in server

EmployeeModel? sendData; //stores the value send by the server as response

TextEditingController usernameController = TextEditingController(); //for username text field
TextEditingController passwordController = TextEditingController(); //for password text field

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    check = false;
    okCheck = false;
  }


  @override
  Widget build(BuildContext context) {
    return updateAlert(context);
  }

Widget updateAlert(BuildContext context){
  //action buttons
  Widget updateBtn = TextButton(onPressed: () async{
    // Navigator.of(context).pop();
    setState(() {
      if(usernameController.text.isEmpty || passwordController.text.isEmpty){
        empty = true;
      }else{
        empty = false;
      }

    });

    //performing Update Action when none of the text field is empty
    if(!empty) {

      sendData = await updateEmployee(
          usernameController.text, passwordController.text, widget.nameToGet);

      setState(() {
        check = true;
        if(sendData?.username !="" && sendData?.password !=""){
          ifError[0] = false;
          if(sendData != null){
            ifError[1] = false;
          }else{
            ifError[1] = true;
          }
        }else{
          ifError[0] = true;
          ifError[1] = false;
        }

        print(ifError[0]);
        print(ifError[1]);
        if(!ifError[0] && !ifError[1]){
          okCheck = true;
        }
      });

    }
  }, child: Text("Update"));


  Widget cancelBtn = TextButton(
      onPressed: (){Navigator.of(context).pop();
      setState(() {
        check = false;
      });
      }, child: Text("Cancel"));

  Widget okBtn = TextButton(
      onPressed: (){
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => UpdateEmployee()),
              (route) => false);
      setState(() {
        check = false;
      });
      }, child: Text("Ok"));

  Widget reNameBtn = TextButton(
      onPressed: (){
        setState(() {
          check = false;
          ifError[0] = false;
          ifError[1] = false;
        });
      }, child: Text("Rename"));

  Widget cancelBtn2 = TextButton(
      onPressed: (){
        Navigator.pop(context);
        setState(() {
          check = false;
        });
      }, child: Text("Cancel"));

  Widget okBtn2 = TextButton(
      onPressed: (){
        Navigator.pop(context);
        setState(() {
          check = false;
        });
      }, child: Text("Ok"));
  //text fields
  Widget usernameField = SizedBox(
    width: 200,
    child: TextField(
      controller: usernameController,
      decoration: InputDecoration(
          labelText: "Enter employee's username",
          hintText: "username",
          errorText: empty? "Username can't be empty" : null
      ),
    ),
  );

  Widget passwordField = SizedBox(
    width: 200,
    child: TextField(
      controller: passwordController,
      decoration: InputDecoration(
          labelText: "Enter employee's password",
          hintText: "password",
          errorText: empty? "Password can't be empty" : null
      ),
    ),
  );





  AlertDialog alertDialog = AlertDialog(
    contentPadding: EdgeInsets.zero,
    title: Text("Update username"),
    content: Container(
      height: 200,
      child: Column(
        children: [
          (check)? Text("") : usernameField,
          SizedBox(height: 20,),
          (check)? Text("") : passwordField,
          (okCheck)? Text("Updated successfully"): Text(""),
          ifError[0]? Center(child: Text("Already exists in database")) : Text(""),
          ifError[1] ? Center(child: Text("Failed to update data")) : Text("")

        ],
      ),
    ),
    actions: [
      (check)? Text("") : updateBtn,
      (check)? Text("") : cancelBtn,
      (okCheck)? Center(child: okBtn) : Text(''),
      ifError[0]? reNameBtn : Text(""),
      ifError[0]? cancelBtn2 : Text(""),
      ifError[1]? okBtn2 : Text("")
    ],
  );

          return alertDialog;
      }
}
