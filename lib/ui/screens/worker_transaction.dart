import 'package:abdelkader1/controllers/controllers.dart';
import 'package:abdelkader1/models/models.dart';
import 'package:abdelkader1/ui/ui.dart';
import 'package:flutter/material.dart';

class WorkerTransactions extends StatefulWidget {
  final String uid;

  WorkerTransactions({this.uid});

  @override
  _WorkerTransactionsState createState() => _WorkerTransactionsState();
}

class _WorkerTransactionsState extends State<WorkerTransactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Transactions'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Stack(
          children: [
            StreamBuilder<List<TR>>(
                stream:
                DataBaseController(uid: this.widget.uid).workerTransactions,
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
