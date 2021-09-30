import 'package:abdelkader1/constants/colors.dart';
import 'package:abdelkader1/models/models.dart';
import 'package:abdelkader1/ui/screens/screens.dart';
import 'package:flutter/material.dart';

class Chantier_card extends StatelessWidget {
  final Chantier data;

  Chantier_card({this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
        trailing: Icon(Icons.chevron_right,size: 30,color: primaryColor,),
        leading: Icon(
          Icons.place,
          color: primaryColor,
          size: 35,
        ),
        title: Text(
          data.name,
          style: TextStyle(fontSize: 18),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChantierTransactions(
                        name: data.name,
                      )));
        },
      ),
    );
  }
}
