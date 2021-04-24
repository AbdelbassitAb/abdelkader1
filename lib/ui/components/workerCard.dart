
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
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          trailing: Icon(Icons.chevron_right),
          leading: CircleAvatar(
            radius: 25.0,
            backgroundImage: AssetImage('assets/images/user.png'),
            backgroundColor: Colors.white,
          ),
          title: Text(
            data.name,
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