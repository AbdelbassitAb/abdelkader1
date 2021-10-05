import 'package:abdelkader1/constants/colors.dart';
import 'package:abdelkader1/controllers/controllers.dart';
import 'package:abdelkader1/models/models.dart';
import 'package:abdelkader1/ui/components/components.dart';
import 'package:flutter/material.dart';

class Payement extends StatefulWidget {
  @override
  _PayementState createState() => _PayementState();
}

class _PayementState extends State<Payement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  backgroundColor: secondaryColor,

      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Payement'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Stack(
        children: [
          StreamBuilder<List<TR>>(
              stream: DataBaseController().transactionQuery('type','Payement'),
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
              })
        ],
      ),
    );
  }
}
