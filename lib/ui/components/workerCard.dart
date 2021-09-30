
import 'package:abdelkader1/constants/constants.dart';
import 'package:abdelkader1/models/models.dart';
import 'package:abdelkader1/ui/ui.dart';
import 'package:flutter/material.dart';

class Worker_card extends StatelessWidget {
  final Workerr data;

  Worker_card({this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        color: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: ListTile(

          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          trailing: Icon(Icons.chevron_right,color: Colors.white,size: 30,),
          leading: CircleAvatar(
            radius: 25.0,
            backgroundImage: AssetImage('assets/images/user.png'),
            backgroundColor: Colors.white,
          ),
          title: Text(
            data.name,
            style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),
          ),

          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WorkerTransactions(uid: data.uid,)));
          },
        ),
      ),
    );
  }
}