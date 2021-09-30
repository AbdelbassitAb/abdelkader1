import 'package:abdelkader1/constants/colors.dart';
import 'package:abdelkader1/models/models.dart';
import 'package:abdelkader1/ui/ui.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final ChefData data;

  UserCard({this.data});

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
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              data.numTlf,
              style: TextStyle(fontSize: 16,color: Colors.white.withOpacity(0.7)),
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Profile_Transactions(
                      uid: data.uid,
                      name: data.name,
                      email: data.email,
                      phoneNumber: data.numTlf,
                      money: data.argent,
                      deleted: data.deleted,
                    )));
          },
        ),
      ),
    );
  }
}
