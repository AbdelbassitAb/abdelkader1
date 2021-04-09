
import 'package:abdelkader1/ui/ui.dart';
import 'package:flutter/material.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chefs chantier',
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[

          UsersList(),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddChefScreen()));
              },
            ),
          ),


        ],
      ),
    );
  }
}
