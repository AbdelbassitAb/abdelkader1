import 'package:abdelkader1/constants/colors.dart';
import 'package:abdelkader1/controllers/controllers.dart';
import 'package:abdelkader1/models/models.dart';
import 'package:abdelkader1/ui/components/components.dart';
import 'package:flutter/material.dart';

class AchatMateriaux extends StatefulWidget {
  @override
  _AchatMateriauxState createState() => _AchatMateriauxState();
}

class _AchatMateriauxState extends State<AchatMateriaux> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: secondaryColor,
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Achat materiaux'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: StreamBuilder<List<TR>>(
          stream: DataBaseController().transactionQuery('type', 'Achat materiaux'),
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
