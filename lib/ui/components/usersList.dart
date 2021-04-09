import 'package:abdelkader1/models/models.dart';
import 'package:abdelkader1/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {

  @override
  Widget build(BuildContext context) {
    final usersList = Provider.of<List<ChefData>>(context) ?? [];

    return usersList.length == 0 ? Center(child: Text('Pas de chef ajouté'))  :  ListView.builder(
      itemCount: usersList.length,
      itemBuilder: (context, index) {
        if (usersList[index].deleted == false) {
          return UserCard(data: usersList[index]);
        } else
          return SizedBox(
            height: 0,
          );
      },
    );
  }
}
