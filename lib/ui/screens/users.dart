import 'package:abdelkader1/constants/colors.dart';
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
      value: DataBaseController().chefs,
      child: Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Text(
            'Chefs chantiers',
          ),
          centerTitle: true,
          backgroundColor: primaryColor,
        ),
        body: UsersList(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: primaryColor,
          onPressed: () async {
            await showModalBottomSheet<dynamic>(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return Container(
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(25.0),
                            topRight: const Radius.circular(25.0))),
                    child: Wrap(children: [AddChefScreen()]),
                  );
                });
          },
        ),
      ),
    );
  }
}
