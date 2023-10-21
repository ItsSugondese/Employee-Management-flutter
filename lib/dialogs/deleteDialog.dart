import 'package:flutter/material.dart';

import '../model/employeeModel.dart';
import '../model/networkingModel.dart';
import '../screen/deleteEmployee.dart';

//class that shows pop up when clicked on delete icon
class DeleteDialog extends StatelessWidget {

  String name; //name of an item getting deleted


  late Future<EmployeeModel> sheesh;   //for performing DELETE operation in network

  DeleteDialog({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return rYouSure(context, name);
  }


  //returns AlertDialog widget
  Widget rYouSure(BuildContext context, String data){
    //action buttons
    Widget noBtn = TextButton(
        onPressed: (){
          Navigator.of(context).pop(false); //sending "false" data in parent screen
        }, child: Text("No"));

    Widget yesBtn = TextButton(
        onPressed: () async{
          sheesh = deleteEmployee(data);
          print("here");
          Navigator.pop(context, true); //sending "true" data in parent screen


        }, child: Text("Yes"));

    //text fields

    AlertDialog alertDialog = AlertDialog(
      contentPadding: EdgeInsets.zero,
      title: Text("Update username"),
      content: Container(
      height: 30,),
      actions: [
        yesBtn,
        noBtn
      ],
    );

    return alertDialog;
  }
}
