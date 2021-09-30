import 'package:abdelkader1/constants/colors.dart';
import 'package:abdelkader1/controllers/controllers.dart';
import 'package:abdelkader1/models/models.dart';
import 'package:abdelkader1/ui/components/components.dart';
import 'package:flutter/material.dart';

class ChantierTransactions extends StatefulWidget {
  final String name;

  ChantierTransactions({this.name});

  @override
  _ChantierTransactionsState createState() => _ChantierTransactionsState();
}

class _ChantierTransactionsState extends State<ChantierTransactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(this.widget.name),
          centerTitle: true,
          backgroundColor: primaryColor,
        ),
        body: Stack(
          children: [
            StreamBuilder<List<TR>>(
                stream:
                DataBaseController().chantier(this.widget.name),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length != 0) {
                      snapshot.data.sort((a,b) {
                        return b.time.compareTo(a.time);
                      });
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Transaction_Card(
                              data: snapshot.data[index]);
                        },
                      );
                    } else {
                      return Center(
                          child: Text('Pas de transaction trouvé'));
                    }
                  } else {
                    return Center(
                        child: CircularProgressIndicator());
                  }
                }
            )
          ],
        ));
  }
}
