import 'package:abdelkader1/constants/constants.dart';
import 'package:abdelkader1/controllers/controllers.dart';
import 'package:abdelkader1/models/models.dart';
import 'package:abdelkader1/ui/components/components.dart';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ChefData> list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  backgroundColor: secondaryColor,
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Page principale'),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: StreamBuilder<List<TR>>(
          stream: DataBaseController().allTransactions,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                if (snapshot.data.length == 0) {
                  return Center(
                    child: Text('Pas de transaction trouvé'),
                  );
                } else {
                  snapshot.data.sort((a,b) {
                    return b.time.compareTo(a.time);
                  });
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Transaction_Card(data: snapshot.data[index]);
                    },
                  );
                }
              } else {
                return Center(
                  child: Text('Pas de transaction trouvé'),
                );
              }
            } else
              return Center(
                child: CircularProgressIndicator(),
              );
          }),
    );
  }
}
