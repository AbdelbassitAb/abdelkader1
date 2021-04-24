
import 'package:abdelkader1/controllers/controllers.dart';
import 'package:abdelkader1/models/models.dart';
import 'package:abdelkader1/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ChefData>>.value(
      value: DataBaseController().chefs ,
      child: Scaffold(
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
      ),
    );
  }
}
