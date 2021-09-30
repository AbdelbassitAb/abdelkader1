import 'package:abdelkader1/constants/colors.dart';
import 'package:abdelkader1/controllers/controllers.dart';
import 'package:abdelkader1/models/models.dart';
import 'package:abdelkader1/ui/components/components.dart';
import 'package:flutter/material.dart';


class Nouriture extends StatefulWidget {
  @override
  _NouritureState createState() => _NouritureState();
}

class _NouritureState extends State<Nouriture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Nouriture'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Stack(
        children: [
          StreamBuilder<List<TR>>(
              stream: DataBaseController().transactionsOf('Nouriture'),
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
